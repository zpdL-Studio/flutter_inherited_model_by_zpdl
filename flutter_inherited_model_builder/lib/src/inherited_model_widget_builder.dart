// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'code_indent_writer.dart';

class InheritedModelWidgetBuilder {
  static String build({
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
    code.write(_buildInheritedModelOf(inheritedModelWidgetName, constructorParameters ?? [], fields));
    code.line();
    code.write(_buildInheritedModelConstructor(name, constructorParameters));
    code.line();
    code.write(_buildInheritedModelField(constructorParameters));
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
      ...fields.map((e) => (e.type, e.isOptional(), e.name)),
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
      List<ParameterElement>? constructorParameters,
      ) {
    if(constructorParameters == null || constructorParameters.isEmpty) {
      return 'const $name({super.key, required this.child});';
    }
    final code = CodeIndentWriter();
    code.write('const $name({');
    code.openIndent();
    code.write('super.key,');
    for(final e in constructorParameters) {
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
    code.write('required this.child');
    code.closeIndent();
    code.write('});');
    return code.toString();
  }

  static String _buildInheritedModelField(
    List<ParameterElement>? constructorParameters,
  ) {
    final code = CodeIndentWriter();
    if (constructorParameters != null && constructorParameters.isNotEmpty) {
      for (final e in constructorParameters) {
        code.write('final ${e.type} ${e.name};');
      }
    }
    code.write('final Widget child;');
    return code.toString();
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