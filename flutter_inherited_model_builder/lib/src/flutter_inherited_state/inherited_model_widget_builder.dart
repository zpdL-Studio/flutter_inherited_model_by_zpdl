// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:flutter_inherited_model_builder/src/code_indent_writer.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/annotation_info.dart';
import 'package:flutter_inherited_model_builder/src/builder_util.dart';

class InheritedModelWidgetBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required String elementName,
    required String modelName,
    required String inheritedModelWidgetName,
    required String inheritedModelStateName,
    required List<ParameterElement> constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeIndentWriter();
    code.write('class $name extends StatefulWidget {');
    code.openIndent();
    code.write('''
static $elementName model(BuildContext context) {
  return maybeModel(context)!;
}

static $elementName? maybeModel(BuildContext context) {
  return context.getInheritedWidgetOfExactType<$inheritedModelWidgetName>()?.model;
}
''');
    code.line();
    int dependencyIndex = constructorParameters.length + fields.length;
    if (annotation.useAsyncWorker) {
      code.write('''
static bool asyncWorkingOf(BuildContext context) {
  return InheritedModel.inheritFrom<$inheritedModelWidgetName>(context, aspect: ${dependencyIndex++})?.asyncWorking ?? false;
}
''');
    }

    code.write(
      _buildInheritedModelOf(
        inheritedModelWidgetName,
        constructorParameters,
        fields,
      ),
    );
    code.line();
    code.write(_buildInheritedModelConstructor(name, modelName));
    code.line();
    code.write(_buildInheritedModelField(elementName));
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
        final maybeOf =
            'maybe${name.substring(0, 1).toUpperCase()}${name.substring(1)}Of';
        code.write('''
static $type ${name}Of(BuildContext context) => $maybeOf(context)!;

static $type? maybe${name.substring(0, 1).toUpperCase()}${name.substring(1)}Of(BuildContext context) {
  return InheritedModel.inheritFrom<$inheritedModelWidgetName>(context, aspect: $i)?.$name;
}
''');
      }
    }

    return code.toString();
  }

  static String _buildInheritedModelConstructor(String name, String modelName) {
    return '''
const $name({
  super.key,
  required this.value,
  required this.child,
}): assert(value is $modelName);
''';
  }

  static String _buildInheritedModelField(String elementName) {
    return '''
final $elementName value;
final Widget child;
''';
  }
}
