// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';

import 'annotation_info.dart';
import 'code_indent_writer.dart';

class MixinBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required List<ParameterElement>? constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeIndentWriter();
    code.write('mixin $name {');
    code.openIndent();
    code.line();
    if (constructorParameters != null && constructorParameters.isNotEmpty) {
      for (final e in constructorParameters) {
        code.write(
          '${e.type} get ${e.name} => throw UnimplementedError(\'${e.name} has not been implemented.\');',
        );
      }
    }
    code.line();
    if (annotation.useStateCycle) {
      final useStateParameter = StringBuffer();
      if (constructorParameters != null && constructorParameters.isNotEmpty) {
        for (final e in constructorParameters) {
          if (useStateParameter.isNotEmpty) {
            useStateParameter.write(', ');
          }
          useStateParameter.write('${e.type} ${e.name}');
        }
      }

      code.write('''
void onInitState() {}

void onDidUpdateWidget($useStateParameter) {}

void onDispose() {}
''');
    }

    if (annotation.useStateCycle) {
      code.write('''
void onDidChangeAppLifecycleState(AppLifecycleState state) {}
''');
    }

    if (annotation.useAsyncWorker) {
      code.write('''
void Function(Object e, StackTrace stackTrace)? asyncWorkerDefaultError;

void asyncWorker(Future<void> Function() worker, [void Function(Object e, StackTrace stackTrace)? error]) => throw UnimplementedError('asyncWorker has not been implemented.');
''');
    }

    final event = annotation.event;
    if (event != null) {
      code.write('''
Future<dynamic> emitEvent($event event) => throw UnimplementedError('emitEvent($event event) has not been implemented.');
''');
    }

    if(annotation.useSingleTickerProvider || annotation.useTickerProvider) {
      code.write('''
TickerProvider get tickerProvider => throw UnimplementedError('tickerProvider has not been implemented.');
''');
    }
    code.closeIndent();
    code.write('}');

    return code.toString();
  }
}
