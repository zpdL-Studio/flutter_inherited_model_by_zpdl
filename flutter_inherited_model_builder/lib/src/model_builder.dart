// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';

import 'annotation_info.dart';
import 'code_indent_writer.dart';

class ModelBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required String elementName,
    required List<ParameterElement>? constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeIndentWriter();
    final mixins = StringBuffer();

    code.write('class $name extends $elementName${mixins.toString()} {');
    code.openIndent();
    code.line();
    code.write('''
StateSetter? _\$setState;

// ignore: unused_element
void _setState(VoidCallback fn) {
  final setState = _\$setState;
  if (setState == null) {
    fn();
    return;
  }
  setState(fn);
}''');
    code.line();
    if (constructorParameters == null || constructorParameters.isEmpty) {
      code.write('$name(): super._();');
    } else {
      for (final e in constructorParameters) {
        code.write('${e.type} ${getConstructorName(e.name)};');
      }
      code.line();
      code.write('$name({');
      code.writeIndent((code) {
        for (final e in constructorParameters) {
          if(e.isRequired) {
            code.write('required ${e.type} ${e.name},');
          } else {
            code.write('${e.type} ${e.name},');
          }
        }
      });

      code.write(
        '}): ${constructorParameters.fold(
            '', (previousValue, element) => '$previousValue${getConstructorName(
            element.name)} = ${element.name}, ')}super._();',
      );
    }
    code.line();
    if (constructorParameters != null && constructorParameters.isNotEmpty) {
      for(final e in constructorParameters) {
        code.write('@override');
        code.write('${e.type} get ${e.name} => ${getConstructorName(e.name)};');
      }
      code.line();
    }
    for(final e in fields) {
      code.write(_buildField(e));
    }

    if(annotation.useAsyncWorker) {
      code.write('''
int _\$asyncWorkingCount = 0;

bool get _asyncWorking => _\$asyncWorkingCount > 0;

@override
void asyncWorker(Future<void> Function() worker, [void Function(Object e, StackTrace stackTrace)? error]) async {
  final asyncWorking = _asyncWorking;
  _\$asyncWorkingCount++;
  if (_asyncWorking != asyncWorking) {
    try {
      _setState(() {});
    } catch (_) {}
  }
  try {
    await worker();
  } catch (e, stackTrace) {
    (error ?? asyncWorkerDefaultError)?.call(e, stackTrace);
  } finally {
    final asyncWorking = _asyncWorking;
    _\$asyncWorkingCount--;
    if (_asyncWorking != asyncWorking) {
      try {
        _setState(() {});
      } catch (_) {}
    }
  }  
}
''');
    }

    final event = annotation.event;
    if (event != null) {
        code.write('''
Future<dynamic> Function($event)? _\$event;

@override
Future<dynamic> emitEvent($event event) async {
  return await _\$event?.call(event);
}
''');
    }

    if (annotation.useSingleTickerProvider || annotation.useTickerProvider) {
      code.write('''
late final TickerProvider Function() _\$tickerProvider;

@override
TickerProvider get tickerProvider => _\$tickerProvider();
''');
    }
    code.closeIndent();
    code.write('}');

    // print('ModelBuilder.builder ->\n${code.toString()}');
    return code.toString();
  }

  static String _buildField(FieldElement field) {
    return '''
@override
set ${field.name}(${field.type} value) {
  _setState(() => super.${field.name} = value);
}
    ''';
  }

  static String getConstructorName(String name) => '_\$$name';
}
