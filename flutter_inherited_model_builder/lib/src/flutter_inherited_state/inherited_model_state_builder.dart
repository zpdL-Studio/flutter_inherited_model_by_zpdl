// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_inherited_model_builder/src/code_indent_writer.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/annotation_info.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/model_builder.dart';

class InheritedModelStateBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required String inheritedModelName,
    required String modelName,
    required String inheritedModelWidgetName,
    required List<ParameterElement> constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeIndentWriter();
    code.write('class $name extends State<$inheritedModelName> {');
    code.openIndent();
    code.write('''

late $modelName _model;

@override
void initState() {
  super.initState();
  _model = widget.value as $modelName;
  _model.onAttachState();
  _model._changeNotifier.addListener(_updateValue);
}

@override
void didUpdateWidget($inheritedModelName oldWidget) {
  super.didUpdateWidget(oldWidget);
  if(_model != widget.value) {
    _model._changeNotifier.removeListener(_updateValue);
    _model.onDetachState();
    _model = widget.value as $modelName;
    _model.onAttachState();
    _model._changeNotifier.addListener(_updateValue);
  }
}

@override
void dispose() {
  _model._changeNotifier.removeListener(_updateValue);
  _model.onDetachState();
  super.dispose();
}

void _updateValue() {
  setState(() {});
}
''');
    // code.write(
    //     _buildDidUpdateWidget(inheritedModelName, constructorParameters));

    code.write(
      _build(
        annotation,
        inheritedModelWidgetName,
        constructorParameters,
        fields,
      ),
    );
    code.closeIndent();
    code.write('}');
    // print('InheritedModelStateBuilder.builder ->\n${code.toString()}');
    return code.toString();
  }


  static String _buildDidUpdateWidget(
    String inheritedModelName,
    List<ParameterElement> constructorParameters,
  ) {
    final compareString = StringBuffer();
    final didUpdateString = StringBuffer();
    for (final e in constructorParameters) {
      if (compareString.isNotEmpty) {
        compareString.write(' || ');
      }
      compareString.write('widget.${e.name} != oldWidget.${e.name}');
      if (didUpdateString.isNotEmpty) {
        didUpdateString.write(', ');
      }
      didUpdateString.write('widget.${e.name}');
    }

    final code = CodeIndentWriter();
    code.write('''
@override
void didUpdateWidget($inheritedModelName oldWidget) {
  super.didUpdateWidget(oldWidget);
''');
    code.openIndent();
    code.write('if(${compareString.toString()}) {');
    code.writeIndent((code) {
      code.write('_model.onDidUpdateWidget(${didUpdateString.toString()});');
      for (final e in constructorParameters) {
        code.write(
          '_model.${ModelBuilder.getConstructorName(e.name)} = widget.${e.name};',
        );
      }
    });
    code.write('}');
    code.closeIndent();
    code.write('}');
    return code.toString();
  }

  static String _build(
    AnnotationInfo annotation,
    String inheritedModelWidgetName,
    List<ParameterElement> constructorParameters,
    List<FieldElement> fields,
  ) {
    final code = CodeIndentWriter();
    code.write('''
@override
Widget build(BuildContext context) {''');
    code.openIndent();
    code.write('return $inheritedModelWidgetName(');
    code.writeIndent((code) {
      for (final e in constructorParameters) {
        code.write('${e.name}: _model.${e.name},');
      }
      for (final e in fields) {
        code.write('${e.name}: _model.${e.name},');
      }
      if(annotation.useAsyncWorker) {
        code.write('asyncWorking: _model._asyncWorking,');
      }
      code.write('model: _model,');
      code.write('child: widget.child');
    });
    code.write(');');

    code.closeIndent();
    code.write('}');
    return code.toString();
  }
}
