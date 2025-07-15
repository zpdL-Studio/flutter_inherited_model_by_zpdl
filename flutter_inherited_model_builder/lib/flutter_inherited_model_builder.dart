// ignore_for_file: deprecated_member_use
import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_inherited_model/annotation/annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'code_writer.dart';

Builder flutterInheritedModelBuilder(BuilderOptions options) =>
    SharedPartBuilder([
      const FlutterInheritedModelBuilder(),
    ], 'flutterInheritedModelBuilder');

class FlutterInheritedModelBuilder
    extends GeneratorForAnnotation<FlutterInheritedModel> {
  const FlutterInheritedModelBuilder();

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    print('FlutterInheritedModelBuilder -> element : ${element.name}');

    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator cannot be applied to ${element.displayName}.',
        todo: 'This annotation can only be used on classes.',
        element: element,
      );
    }

    final constructorElement = element.unnamedConstructor;
    if (constructorElement == null) {
      throw InvalidGenerationSourceError(
        'The generator could not find an unnamed constructor for this ${element.displayName} class.',
        todo:
            'Ensure the class has a default (unnamed) factory constructor, or adjust the annotation usage.',
        element: element,
      );
    }

    final stateTypeChecker = TypeChecker.fromRuntime(
      FlutterInheritedModelState,
    );
    final fields = <FieldElement>[];
    for (final field in element.fields) {
      if (stateTypeChecker.hasAnnotationOf(field)) {
        if (!field.isStatic && !field.isFinal && field.isPublic) {
          fields.add(field);
        } else {
          final fieldName = field.name;
          throw InvalidGenerationSourceError(
            'The field `$fieldName` annotated with `@FlutterInheritedModelState` must be public, non-static, and non-final.',
            todo:
                'Please ensure `$fieldName` is declared as `late` and is not `static` or `final`.',
            element: field, // Point the error directly to the problematic field
          );
        }
      }
    }

    final constructorParameters = <ParameterElement>[];
    for (final parameter in constructorElement.parameters) {
      if (parameter.isRequiredNamed || parameter.isOptionalNamed) {
        constructorParameters.add(parameter);
      } else {
        final name = parameter.name;
        throw InvalidGenerationSourceError(
          'The construct parameter `$name` is only named parameter',
          todo: 'Please ensure `$name` is changed named parameter',
          element: parameter,
        );
      }
    }

    final code = CodeWriter();

    final modelName = '_\$${element.name}';
    final inheritedModelName =
        _getNameFromAnnotation(annotation) ?? '${element.name}InheritedModel';
    final inheritedModelStateName = '_${inheritedModelName}State';
    final inheritedModelWidgetName = '_$inheritedModelName';

    code.writeln(
      _buildInheritedModel(
        name: inheritedModelName,
        elementName: element.name,
        inheritedModelWidgetName: inheritedModelWidgetName,
        constructorParameters: constructorParameters,
        fields: fields,
      ),
    );

    code.writeln(
      _buildModel(
        name: modelName,
        elementName: element.name,
        constructorParameters: constructorParameters,
        fields: fields,
      ),
    );

    code.writeln(
      _buildInheritedModelState(
        name: inheritedModelStateName,
        inheritedModelName: inheritedModelName,
        modelName: modelName,
        constructorParameters: constructorParameters,
        fields: fields,
      ),
    );

    code.writeln(
      _buildInheritedModelWidget(
        name: inheritedModelWidgetName,
        modelName: element.name,
        fields: fields,
      ),
    );

    return code.toString();
  }
}

extension _FlutterInheritedModelBuilderUtil on FlutterInheritedModelBuilder {
  String? _getNameFromAnnotation(ConstantReader annotation) {
    final name = annotation.read('name');
    if (name.isString) {
      return name.stringValue;
    }
    return null;
  }
}

extension _FlutterInheritedModelBuilderModel on FlutterInheritedModelBuilder {
  String _buildModel({
    required String name,
    required String elementName,
    required List<ParameterElement> constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeWriter();
    code.writeln('class $name extends $elementName {', true);
    code.writeln('$name({', true);
    code.writeln(_buildModelConstructParameters(constructorParameters));
    code.writeln('});', false);
    code.ln();
    code.writeln('StateSetter? _setState;');
    code.ln();
    for (final field in fields) {
      code.writeln('@override');
      code.writeln('set ${field.name}(${field.type} value) {', true);
      code.writeln('final setState = _setState;');
      code.writeln('if (setState == null) {', true);
      code.writeln('super.${field.name} = value;');
      code.writeln('return;');
      code.writeln('}', false);
      code.writeln('setState(() {', true);
      code.writeln('super.${field.name} = value;');
      code.writeln('});', false);
      code.writeln('}', false);
    }
    code.writeln('}', false);
    return code.toString();
  }

  String _buildModelConstructParameters(List<ParameterElement> parameters) {
    final sb = StringBuffer();
    for (final parameter in parameters) {
      if (sb.isNotEmpty) {
        sb.write(', ');
      }
      final name = parameter.name;
      if (parameter.isRequiredNamed) {
        sb.write('required super.$name');
      } else if (parameter.isOptionalNamed) {
        sb.write('super.$name');
      }

      if (parameter.hasDefaultValue) {
        sb.write(' = ${parameter.defaultValueCode}');
      }
    }

    return sb.toString();
  }
}

extension _FlutterInheritedModelBuilderInheritedModel
    on FlutterInheritedModelBuilder {
  String _buildInheritedModel({
    required String name,
    required String elementName,
    required String inheritedModelWidgetName,
    required List<ParameterElement> constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeWriter();
    code.writeln('class $name extends StatefulWidget {', true);
    code.ln();

    code.writeln('static $elementName read(BuildContext context) {', true);
    code.writeln('return context.getInheritedWidgetOfExactType<$inheritedModelWidgetName>()!.model;');
    code.writeln('}', false);
    code.ln();

    for (int i = 0; i < fields.length; i++) {
      final field = fields[i];
      code.writeln(
          'static ${field.type} ${field.name}Of(BuildContext context) {', true);
      code.writeln(
          'return InheritedModel.inheritFrom<$inheritedModelWidgetName>(context, aspect: $i)!.${field
              .name};');
      code.writeln('}', false);
      code.ln();
    }

    code.writeln('const $name({', true);
    code.writeln(
      _buildInheritedModelConstructParameters(constructorParameters),
    );
    code.writeln('});', false);
    code.ln();

    for (final parameter in constructorParameters) {
      if (parameter.isRequiredNamed || parameter.isOptionalNamed) {
        code.writeln('final ${parameter.type} ${parameter.name};');
      }
    }
    code.writeln('final Widget child;');
    code.ln();

    code.writeln('@override');
    code.writeln('State<$name> createState() => _${name}State();');

    code.writeln('}', false);

    return code.toString();
  }

  String _buildInheritedModelConstructParameters(
    List<ParameterElement> parameters,
  ) {
    final sb = StringBuffer();
    sb.write('super.key, ');
    for (final parameter in parameters) {
      final name = parameter.name;
      if (parameter.isRequiredNamed) {
        sb.write('required this.$name');
      } else if (parameter.isOptionalNamed) {
        sb.write('this.$name');
      }

      if (parameter.hasDefaultValue) {
        sb.write(' = ${parameter.defaultValueCode}');
      }
      sb.write(', ');
    }
    sb.write('required this.child');
    return sb.toString();
  }
}

extension _FlutterInheritedModelBuilderInheritedModelState
    on FlutterInheritedModelBuilder {
  String _buildInheritedModelState({
    required String name,
    required String inheritedModelName,
    required String modelName,
    required List<ParameterElement> constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeWriter();
    code.writeln(
        'class $name extends State<$inheritedModelName> {', true
    );
    code.writeln('late final $modelName _model;');
    code.ln();

    code.writeln(__initState(modelName, constructorParameters));
    code.ln();

    code.writeln('@override');
    code.writeln('void dispose() {', true);
    code.writeln('_model._setState = null;');
    code.writeln('super.dispose();');
    code.writeln('}', false);
    code.ln();

    code.writeln('@override');
    code.writeln('Widget build(BuildContext context) {', true);
    code.writeln(
      'return _$inheritedModelName(${_buildInheritedModelStateFields(fields)});',
    );
    code.writeln('}', false);

    code.writeln('}', false);

    return code.toString();
  }

  String __initState(String modelName,
      List<ParameterElement> constructorParameters) {
    final code = CodeWriter();
    code.writeln('@override');
    code.writeln('void initState() {', true);
    code.writeln('super.initState();');
    if (constructorParameters.isEmpty) {
      code.writeln('_model = $modelName();');
    } else {
      code.writeln('_model = $modelName(', true);
      for (final parameter in constructorParameters) {
        code.writeln('${parameter.name}: widget.${parameter.name},');
      }
      code.writeln(');', false);
    }
    code.writeln('_model._setState = setState;');
    code.writeln('}', false);
    return code.toString();
  }

  String _buildInheritedModelStateFields(List<FieldElement> fields) {
    final sb = StringBuffer();
    for (final field in fields) {
      sb.write('${field.name}: _model.${field.name}');
      sb.write(', ');
    }
    sb.write('model: _model, ');
    sb.write('child: widget.child');
    return sb.toString();
  }
}

extension _FlutterInheritedModelBuilderInheritedModelWidget
    on FlutterInheritedModelBuilder {
  String _buildInheritedModelWidget({
    required String name,
    required String modelName,
    required List<FieldElement> fields,
  }) {
    final code = CodeWriter();
    code.writeln('class $name extends InheritedModel<int> {', true);
    for (final field in fields) {
      code.writeln('final ${field.type} ${field.name};');
    }
    code.writeln('final $modelName model;');
    code.ln();

    code.writeln('const $name({', true);
    for (final field in fields) {
      code.writeln('required this.${field.name},');
    }
    code.writeln('required this.model,');
    code.writeln('required super.child,');
    code.writeln('});', false);
    code.ln();

    code.writeln('@override');
    code.writeln('bool updateShouldNotify($name oldWidget) {', true);
    String updateShouldNotify(List<FieldElement> fields) {
      if (fields.isEmpty) {
        return 'true';
      }
      final sb = StringBuffer();
      for (final field in fields) {
        if (sb.isNotEmpty) {
          sb.write(' || ');
        }
        sb.write('${field.name} != oldWidget.${field.name}');
      }
      return sb.toString();
    }

    code.writeln('return ${updateShouldNotify(fields)};');
    code.writeln('}', false);
    code.ln();

    code.writeln('@override');
    code.writeln(
      'bool updateShouldNotifyDependent($name oldWidget, Set<int> dependencies) {',
      true
    );
    for (int i = 0; i < fields.length; i++) {
      final field = fields[i];
      code.writeln(
        'if (${field.name} != oldWidget.${field.name} && dependencies.contains($i)) {',
        true
      );
      code.writeln('return true;');
      code.writeln('}', false);
      code.ln();
    }
    code.ln();
    code.writeln('return false;');
    code.writeln('}', false);
    code.ln();

    code.writeln('}', false);

    return code.toString();
  }
}
