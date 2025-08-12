// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_inherited_model_builder/src/code_indent_writer.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/annotation_info.dart';

class MixinBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required List<ParameterElement> constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeIndentWriter();
    code.write('mixin $name {');
    code.openIndent();
    code.line();
    if (constructorParameters.isNotEmpty) {
      for (final e in constructorParameters) {
        code.write(
          '${e.type} get ${e.name} => throw UnimplementedError(\'${e.name} has not been implemented.\');',
        );
      }
    }
    code.line();

    code.write('''
void onAttachState() {}

void onDetachState() {}

void dispose() {}
''');

    if (annotation.useAsyncWorker) {
      code.write('''
void Function(Object e, StackTrace stackTrace)? asyncWorkerDefaultError;

void asyncWorker(Future<void> Function() worker, [void Function(Object e, StackTrace stackTrace)? error]) => throw UnimplementedError('asyncWorker has not been implemented.');
''');
    }

    code.closeIndent();
    code.write('}');

    return code.toString();
  }
}
