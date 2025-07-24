// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:flutter_inherited_model_builder/src/annotation_info.dart';
import 'package:flutter_inherited_model_builder/src/builder_util.dart';

import 'code_indent_writer.dart';

class InheritedModelWidgetBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required String elementName,
    required String inheritedModelWidgetName,
    required String inheritedModelStateName,
    required List<ParameterElement>? constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeIndentWriter();
    code.write('class $name extends StatefulWidget {');
    code.openIndent();
    code.write('''
static $elementName model(BuildContext context) {
  return context.getInheritedWidgetOfExactType<$inheritedModelWidgetName>()!.model;
}

static $elementName? maybeModel(BuildContext context) {
  return context.getInheritedWidgetOfExactType<$inheritedModelWidgetName>()?.model;
}
''');
    code.line();
    code.write(
      _buildInheritedModelOf(
        inheritedModelWidgetName,
        constructorParameters ?? [],
        fields,
      ),
    );
    code.line();
    code.write(
      _buildInheritedModelConstructor(name, annotation, constructorParameters),
    );
    code.line();
    code.write(_buildInheritedModelField(annotation, elementName, constructorParameters));
    code.line();
    code.write('''
@override
State<$name> createState() => $inheritedModelStateName();
''');
    code.closeIndent();
    code.write('}');

    // print('InheritedModelBuilder.builder ->\n${code.toString()}');
    return code.toString();
  }

  static String _buildInheritedModelOf(
    String inheritedModelWidgetName,
    List<ParameterElement> constructorParameters,
    List<FieldElement> fields,
  ) {
    final parameter = <(DartType type, bool optional, String name)>[
      ...constructorParameters.map((e) => (e.type, e.isOptional, e.name)),
      ...fields.map((e) => (e.type, e.type.isOptional(), e.name)),
    ];

    final code = CodeIndentWriter();
    for (int i = 0; i < parameter.length; i++) {
      final (DartType type, bool optional, String name) = parameter[i];
      if (optional) {
        code.write('''
static $type ${name}Of(BuildContext context) {
  return InheritedModel.inheritFrom<$inheritedModelWidgetName>(context, aspect: $i)?.$name;
}
''');
      } else {
        code.write('''
static $type ${name}Of(BuildContext context) {
  return InheritedModel.inheritFrom<$inheritedModelWidgetName>(context, aspect: $i)!.$name;
}

static $type? maybe${name.substring(0, 1).toUpperCase()}${name.substring(1)}Of(BuildContext context) {
  return InheritedModel.inheritFrom<$inheritedModelWidgetName>(context, aspect: $i)?.$name;
}
''');
      }
    }

    return code.toString();
  }

  static String _buildInheritedModelConstructor(
    String name,
    AnnotationInfo annotation,
    List<ParameterElement>? constructorParameters,
  ) {
    if (constructorParameters == null || constructorParameters.isEmpty) {
      return 'const $name({super.key, required this.child});';
    }
    final code = CodeIndentWriter();
    code.write('const $name({');
    code.openIndent();
    code.write('super.key,');
    for (final e in constructorParameters) {
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
      code.write(sb.toString());
    }

    final event = annotation.event;
    if (event != null) {
      code.write('this.onEvent,');
    }
    code.write('required this.child');
    code.closeIndent();
    code.write('});');
    return code.toString();
  }

  static String _buildInheritedModelField(
    AnnotationInfo annotation,
    String elementName,
    List<ParameterElement>? constructorParameters,
  ) {
    final code = CodeIndentWriter();
    if (constructorParameters != null && constructorParameters.isNotEmpty) {
      for (final e in constructorParameters) {
        code.write('final ${e.type} ${e.name};');
      }
    }
    final event = annotation.event;
    if (event != null) {
      code.write('final Future<dynamic> Function($elementName model, $event event)? onEvent;');
    }
    code.write('final Widget child;');
    return code.toString();
  }
}
