// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_inherited_model_builder/src/code_indent_writer.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/annotation_info.dart';

class InheritedModelBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required String modelName,
    required List<ParameterElement> constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeIndentWriter();
    code.write('class $name extends InheritedModel<int> {');
    code.openIndent();
    code.write(
      _buildField(annotation, modelName, constructorParameters, fields),
    );
    code.line();
    code.write(
      _buildConstruct(annotation, name, constructorParameters, fields),
    );
    code.line();
    code.write(
      _buildUpdateShouldNotify(annotation, name, constructorParameters, fields),
    );
    code.line();
    code.write(
      _buildUpdateShouldNotifyDependent(
        annotation,
        name,
        constructorParameters,
        fields,
      ),
    );
    code.line();
    code.closeIndent();
    code.write('}');

    // print('InheritedModelWidgetBuilder.builder ->\n${code.toString()}');
    return code.toString();
  }

  static String _buildField(
    AnnotationInfo annotation,
    String modelName,
    List<ParameterElement> constructorParameters,
    List<FieldElement> fields,
  ) {
    final code = CodeIndentWriter();
    for (final e in constructorParameters) {
      code.write('final ${e.type} ${e.name};');
    }
    for (final e in fields) {
      code.write('final ${e.type} ${e.name};');
    }
    if (annotation.useAsyncWorker) {
      code.write('final bool asyncWorking;');
    }
    code.write('final $modelName model;');
    return code.toString();
  }

  static String _buildConstruct(
    AnnotationInfo annotation,
    String name,
    List<ParameterElement> constructorParameters,
    List<FieldElement> fields,
  ) {
    final code = CodeIndentWriter();
    code.write('const $name({');
    code.writeIndent((code) {
      for (final e in constructorParameters) {
        code.write('required this.${e.name},');
      }
      for (final e in fields) {
        code.write('required this.${e.name},');
      }
      if (annotation.useAsyncWorker) {
        code.write('required this.asyncWorking,');
      }
      code.write('required this.model,');
      code.write('required super.child');
    });
    code.write('});');
    return code.toString();
  }

  static String _buildUpdateShouldNotify(
    AnnotationInfo annotation,
    String name,
    List<ParameterElement> constructorParameters,
    List<FieldElement> fields,
  ) {
    final code = CodeIndentWriter();
    code.write('@override');
    code.write('bool updateShouldNotify($name oldWidget) {');
    code.openIndent();
    if (constructorParameters.isEmpty && fields.isEmpty) {
      code.write('return false;');
    } else {
      final sb = StringBuffer();
      for (final e in constructorParameters) {
        if (sb.isNotEmpty) {
          sb.write(' || ');
        }
        sb.write('${e.name} != oldWidget.${e.name}');
      }
      for (final e in fields) {
        if (sb.isNotEmpty) {
          sb.write(' || ');
        }
        sb.write('${e.name} != oldWidget.${e.name}');
      }
      if (annotation.useAsyncWorker) {
        if (sb.isNotEmpty) {
          sb.write(' || ');
        }
        sb.write('asyncWorking != oldWidget.asyncWorking');
      }
      code.write('return ${sb.toString()};');
    }
    code.closeIndent();
    code.write('}');
    return code.toString();
  }

  static String _buildUpdateShouldNotifyDependent(
    AnnotationInfo annotation,
    String name,
    List<ParameterElement> constructorParameters,
    List<FieldElement> fields,
  ) {
    final code = CodeIndentWriter();
    code.write('@override');
    code.write(
      'bool updateShouldNotifyDependent($name oldWidget, Set<int> dependencies) {',
    );
    code.openIndent();
    if (constructorParameters.isNotEmpty || fields.isNotEmpty) {
      final parameter = <String>[
        ...constructorParameters.map((e) => e.name),
        ...fields.map((e) => e.name),
      ];

      for (int i = 0; i < parameter.length; i++) {
        final e = parameter[i];
        code.write('''
if (dependencies.contains($i) && $e != oldWidget.$e) {
  return true;
}''');
      }
    }

    int dependencyIndex = constructorParameters.length + fields.length;
    if (annotation.useAsyncWorker) {
      code.write('''
if (dependencies.contains(${dependencyIndex++}) && asyncWorking != oldWidget.asyncWorking) {
  return true;
}''');
    }
    code.write('return false;');
    code.closeIndent();
    code.write('}');
    return code.toString();
  }
}
