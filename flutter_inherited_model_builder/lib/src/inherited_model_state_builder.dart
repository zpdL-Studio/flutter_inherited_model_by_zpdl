// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';

import 'annotation_info.dart';
import 'code_indent_writer.dart';
import 'model_builder.dart';

class InheritedModelStateBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required String inheritedModelName,
    required String modelName,
    required String inheritedModelWidgetName,
    required List<ParameterElement>? constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeIndentWriter();
    final mixins = StringBuffer();
    if(annotation.useTickerProvider) {
      mixins.write('with TickerProviderStateMixin ');
    } else if(annotation.useSingleTickerProvider) {
      mixins.write('with SingleTickerProviderStateMixin ');
    }

    code.write('class $name extends State<$inheritedModelName> ${mixins.toString()}{');
    code.openIndent();
    code.write('late final $modelName _model;');
    if (annotation.useLifecycleState) {
      code.write('late final AppLifecycleListener _lifecycleStateListener; ');
    }
    if (annotation.event != null) {
      code.write('bool _isFrameDraw = false;');
    }
    code.line();

    code.write(_buildInitState(annotation, modelName, constructorParameters));

    if (constructorParameters != null && constructorParameters.isNotEmpty) {
      code.write(
        _buildDidUpdateWidget(inheritedModelName, constructorParameters),
      );
    }
    code.write(_buildDispose(annotation));
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

  static String _buildInitState(
    AnnotationInfo annotation,
    String modelName,
    List<ParameterElement>? constructorParameters,
  ) {
    final code = CodeIndentWriter();
    code.write('@override');
    code.write('void initState() {');
    code.openIndent();

    code.write('super.initState();');
    if (constructorParameters == null || constructorParameters.isEmpty) {
      code.write('_model = $modelName();');
    } else {
      code.write('_model = $modelName(');
      code.openIndent();
      for (final e in constructorParameters) {
        code.write('${e.name}: widget.${e.name},');
      }
      code.closeIndent();
      code.write(');');
    }
    final event = annotation.event;
    if (event != null) {
      code.write('''
_model._\$event = (e) async {
  final onEvent = widget.onEvent;
  if (onEvent != null) {
      if(!_isFrameDraw) {
        final completer = Completer<dynamic>();
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          try {
            completer.complete(await onEvent(_model, e));
          } catch(e) {
            completer.completeError(e);
          }
        });
        return completer.future;
      } else {
        return await onEvent(_model, e);
      }
    }
    return null;
  };
''');
    }
    if(annotation.useSingleTickerProvider || annotation.useTickerProvider) {
      code.write('_model._\$tickerProvider = () => this;');
      code.line();
    }
    if (annotation.useStateCycle) {
      // code.write('_model.onInit(${constructorParameters?.fold(
      //     '', (previousValue, element) =>
      // ('$previousValue${element
      //     .name} = widget.${element.name}')) ?? ''});');
      code.write('_model.onInitState();');
    }
    code.write('_model._\$setState = setState;');
    if (annotation.useLifecycleState) {
      code.write(
        '_lifecycleStateListener = AppLifecycleListener(onStateChange: _model.onDidChangeAppLifecycleState);',
      );
    }
    code.closeIndent();
    code.write('}');
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

  static String _buildDispose(AnnotationInfo annotation) {
    return '''
@override
void dispose() {
  ${annotation.useLifecycleState ? '_lifecycleStateListener.dispose();' : ''}
  ${annotation.event != null ? '_model._\$event = null;' : ''}
  _model._\$setState = null;
  ${annotation.useStateCycle ? '_model.onDispose();' : ''}
  super.dispose();
}
    ''';
  }

  static String _build(
    AnnotationInfo annotation,
    String inheritedModelWidgetName,
    List<ParameterElement>? constructorParameters,
    List<FieldElement> fields,
  ) {
    final code = CodeIndentWriter();
    code.write('''
@override
Widget build(BuildContext context) {''');
    code.openIndent();
    if (annotation.event != null) {
      code.write('_isFrameDraw = true;');
    }
    code.write('return $inheritedModelWidgetName(');
    code.writeIndent((code) {
      if (constructorParameters != null) {
        for (final e in constructorParameters) {
          code.write('${e.name}: _model.${e.name},');
        }
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
