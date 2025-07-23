// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';

import 'code_indent_writer.dart';

class InheritedModelBuilder {
  static String build({
    required String name,
    required String modelName,
    required List<ParameterElement>? constructorParameters,
    required List<FieldElement> fields,
  }) {
    final constructor = constructorParameters ?? [];
    final code = CodeIndentWriter();
    code.write('class $name extends InheritedModel<int> {');
    code.openIndent();
    code.write(_buildField(modelName, constructor, fields));
    code.line();
    code.write(_buildConstruct(name, constructor, fields));
    code.line();
    code.write(_buildUpdateShouldNotify(name, constructor, fields));
    code.line();
    code.write(_buildUpdateShouldNotifyDependent(name, constructor, fields));
    code.line();
    code.closeIndent();
    code.write('}');

    // print('InheritedModelWidgetBuilder.builder ->\n${code.toString()}');
    return code.toString();
  }

  static String _buildField(
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
    code.write('final $modelName model;');
    return code.toString();
  }

  static String _buildConstruct(
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
      code.write('required this.model,');
      code.write('required super.child');
    });
    code.write('});');
    return code.toString();
  }

  static String _buildUpdateShouldNotify(
    String name,
    List<ParameterElement> constructorParameters,
    List<FieldElement> fields,
  ) {
    final code = CodeIndentWriter();
    code.write('@override');
    code.write('bool updateShouldNotify($name oldWidget) {');
    code.openIndent();
    if(constructorParameters.isEmpty && fields.isEmpty) {
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
      code.write('return ${sb.toString()};');
    }
    code.closeIndent();
    code.write('}');
    return code.toString();
  }

  static String _buildUpdateShouldNotifyDependent(
      String name,
      List<ParameterElement> constructorParameters,
      List<FieldElement> fields,
      ) {
    final code = CodeIndentWriter();
    code.write('@override');
    code.write('bool updateShouldNotifyDependent($name oldWidget, Set<int> dependencies) {');
    code.openIndent();
    if(constructorParameters.isNotEmpty || fields.isNotEmpty) {
      final parameter = <String>[
        ...constructorParameters.map((e) => e.name),
        ...fields.map((e) => e.name),
      ];

      for (int i = 0; i < parameter.length; i++) {
        final e = parameter[i];
        code.write('''
if (dependencies.contains($i) && $e != oldWidget.$e) {
  return true;
}'''
        );
      }
    }
    code.write('return false;');
    code.closeIndent();
    code.write('}');
    return code.toString();
  }
}