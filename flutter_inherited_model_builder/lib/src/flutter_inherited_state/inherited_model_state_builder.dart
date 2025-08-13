import 'package:analyzer/dart/element/element2.dart';
import 'package:flutter_inherited_model_builder/src/code_indent_writer.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/annotation_info.dart';

class InheritedModelStateBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required String inheritedModelName,
    required String modelName,
    required String inheritedModelWidgetName,
    required List<FormalParameterElement> constructorParameters,
    required List<FieldElement2> fields,
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

  static String _build(
    AnnotationInfo annotation,
    String inheritedModelWidgetName,
    List<FormalParameterElement> constructorParameters,
    List<FieldElement2> fields,
  ) {
    final code = CodeIndentWriter();
    code.write('''
@override
Widget build(BuildContext context) {''');
    code.openIndent();
    code.write('return $inheritedModelWidgetName(');
    code.writeIndent((code) {
      for (final e in constructorParameters) {
        code.write('${e.displayName}: _model.${e.displayName},');
      }
      for (final e in fields) {
        code.write('${e.displayName}: _model.${e.displayName},');
      }
      if (annotation.useAsyncWorker) {
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
