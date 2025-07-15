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
        inheritedModelStateName: inheritedModelStateName,
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
    print(code.toString());
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
    return '''
class $name extends $elementName {
${CodeWriter()..writelnWithIndent(__buildModelConstruct(name, constructorParameters))}
  
  StateSetter? _setState;
  
${CodeWriter()..writelnWithIndent(fields.fold('', (previousValue, element) {
      return '$previousValue\n${__buildModelFields(element)}';
    }))}
}
''';
  }

  String __buildModelConstruct(String name, List<ParameterElement> parameter) {
    if (parameter.isEmpty) {
      return '$name();';
    }
    return '''
$name({
${parameter.combineString(2, (e) {
      final sb = StringBuffer();
      final name = e.name;
      if (e.isRequiredNamed) {
        sb.write('required super.$name');
      } else if (e.isOptionalNamed) {
        sb.write('super.$name');
      }

      if (e.hasDefaultValue) {
        sb.write(' = ${e.defaultValueCode}');
      }
      sb.write(',');
      return sb.toString();
    })}
});
''';
  }

  String __buildModelFields(FieldElement field) {
    return '''
@override
set ${field.name}(${field.type} value) {
  final setState = _setState;
  if (setState == null) {
    super.${field.name} = value;
    return;
  }
  setState(() {
    super.${field.name} = value;
  });
}
    ''';
  }
}

extension _FlutterInheritedModelBuilderInheritedModel
    on FlutterInheritedModelBuilder {
  String _buildInheritedModel({
    required String name,
    required String elementName,
    required String inheritedModelWidgetName,
    required String inheritedModelStateName,
    required List<ParameterElement> constructorParameters,
    required List<FieldElement> fields,
  }) {
    return '''
class $name extends StatefulWidget {
  static $elementName read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<$inheritedModelWidgetName>()!.model;
  }
  
  static $elementName? maybeRead(BuildContext context) {
    return context.getInheritedWidgetOfExactType<$inheritedModelWidgetName>()?.model;
  }
  
${CodeWriter()..writelnWithIndent(__buildInheritedModelOf(inheritedModelWidgetName, fields))}
  const $name({
    super.key,
${constructorParameters.combineString(4, (e) {
      final sb = StringBuffer();
      final name = e.name;
      if (e.isRequiredNamed) {
        sb.write('required this.$name');
      } else if (e.isOptionalNamed) {
        sb.write('this.$name');
      }

      if (e.hasDefaultValue) {
        sb.write(' = ${e.defaultValueCode}');
      }
      sb.write(',');
      return sb.toString();
    })}
    required this.child,
  });

${constructorParameters.combineString(2, (e) {
      return 'final ${e.type} ${e.name};';
    })}
  final Widget child;
  
  @override
  State<$name> createState() => $inheritedModelStateName();
}
''';
  }

  String __buildInheritedModelOf(
    String inheritedModelWidgetName,
    List<FieldElement> fields,
  ) {
    final sb = StringBuffer();
    for (int i = 0; i < fields.length; i++) {
      final field = fields[i];

      if (field.isOptional()) {
        sb.writeln('''
static ${field.type} ${field.name}Of(BuildContext context) {
  return InheritedModel.inheritFrom<$inheritedModelWidgetName>(context, aspect: $i)?.${field.name};
}
''');
      } else {
        sb.writeln('''
static ${field.type} ${field.name}Of(BuildContext context) {
  return InheritedModel.inheritFrom<$inheritedModelWidgetName>(context, aspect: $i)!.${field.name};
}

static ${field.type}? maybe${field.name.substring(0, 1).toUpperCase()}${field.name.substring(1)}Of(BuildContext context) {
  return InheritedModel.inheritFrom<$inheritedModelWidgetName>(context, aspect: $i)?.${field.name};
}
''');
      }
    }

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
    return '''
class $name extends State<$inheritedModelName> {
  late final $modelName _model;
  
${__initState(modelName, constructorParameters)}

  @override
  void dispose() {
    _model._setState = null;
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return _$inheritedModelName(
${fields.combineString(6, (e) => '${e.name}: _model.${e.name},')}
      model: _model,
      child: widget.child,
    );
  }
}
    ''';
  }

  String __initState(
    String modelName,
    List<ParameterElement> constructorParameters,
  ) {
    final code = CodeWriter(indent: 1);
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
}

extension _FlutterInheritedModelBuilderInheritedModelWidget
    on FlutterInheritedModelBuilder {
  String _buildInheritedModelWidget({
    required String name,
    required String modelName,
    required List<FieldElement> fields,
  }) {
    return '''
class $name extends InheritedModel<int> {
${fields.combineString(2, (e) => 'final ${e.type} ${e.name};')}
  final $modelName model;
  
  const $name({
${fields.combineString(4, (e) => 'required this.${e.name},')}
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify($name oldWidget) {
    return ${__updateShouldNotify(fields)};
  }

  @override
  bool updateShouldNotifyDependent($name oldWidget, Set<int> dependencies) {
${__updateShouldNotifyDependent(fields)}

    return false;
  }
}
    ''';
  }

  String __updateShouldNotify(List<FieldElement> fields) {
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

  String __updateShouldNotifyDependent(List<FieldElement> fields) {
    final sb = CodeWriter();
    sb.writeIndent((code) {
      for (int i = 0; i < fields.length; i++) {
        final field = fields[i];
        final name = field.name;
        code.writeln(
          'if ($name != oldWidget.$name && dependencies.contains($i)) {',
        );
        code.writeIndent((code) {
          code.writeln('return true;');
        });
        code.writeln('}');
      }
    }, 2);

    return sb.toString();
  }
}

extension ListFold<T> on List<T> {
  String combineString(int indent, String Function(T) combine) {
    final indentString = ' ' * indent;
    final sb = StringBuffer();
    for (final item in this) {
      if (sb.isNotEmpty) {
        sb.writeln();
      }
      sb.write('$indentString${combine(item)}');
    }
    return sb.toString();
  }
}

extension _FieldElementUtils on FieldElement {
  bool isOptional() {
    final type = '${this.type}';

    if (type.endsWith('?')) {
      return true;
    } else if (type == 'dynamic') {
      return true;
    }
    return false;
  }
}
