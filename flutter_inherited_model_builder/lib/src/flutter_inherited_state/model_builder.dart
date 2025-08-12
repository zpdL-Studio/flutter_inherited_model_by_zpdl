// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_inherited_model_builder/src/code_indent_writer.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/annotation_info.dart';

class ModelBuilder {
  static String build({
    required AnnotationInfo annotation,
    required String name,
    required String elementName,
    required List<ParameterElement> constructorParameters,
    required List<FieldElement> fields,
  }) {
    final code = CodeIndentWriter();
    code.write('''
class ${name}ChangeNotifier with ChangeNotifier {
  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch(_) {}
  }
}
''');
    code.write('class $name extends $elementName {');
    code.openIndent();
    code.line();
    code.write('final _changeNotifier = ${name}ChangeNotifier();');
    code.line();
    if (constructorParameters.isEmpty) {
      code.write('$name(): super._();');
    } else {
      for (final e in constructorParameters) {
        code.write('final ${e.type} ${getConstructorName(e.name)};');
      }
      code.line();
      code.write('$name({');
      code.writeIndent((code) {
        for (final e in constructorParameters) {
          if (e.isRequired) {
            code.write('required ${e.type} ${e.name},');
          } else {
            code.write('${e.type} ${e.name},');
          }
        }
      });

      code.write(
        '}): ${constructorParameters.fold('', (previousValue, element) => '$previousValue${getConstructorName(element.name)} = ${element.name}, ')}super._();',
      );
    }
    code.line();
    if (constructorParameters.isNotEmpty) {
      for (final e in constructorParameters) {
        code.write('@override');
        code.write('${e.type} get ${e.name} => ${getConstructorName(e.name)};');
      }
      code.line();
    }
    for (final e in fields) {
      code.write(_buildField(e));
    }

    if (annotation.useAsyncWorker) {
      code.write('''
int _\$asyncWorkingCount = 0;

bool get _asyncWorking => _\$asyncWorkingCount > 0;

@override
void asyncWorker(Future<void> Function() worker, [void Function(Object e, StackTrace stackTrace)? error]) async {
  final asyncWorking = _asyncWorking;
  _\$asyncWorkingCount++;
  if (_asyncWorking != asyncWorking) {
    _changeNotifier.notifyListeners();
  }
  try {
    await worker();
  } catch (e, stackTrace) {
    (error ?? asyncWorkerDefaultError)?.call(e, stackTrace);
  } finally {
    final asyncWorking = _asyncWorking;
    _\$asyncWorkingCount--;
    if (_asyncWorking != asyncWorking) {
      _changeNotifier.notifyListeners();
    }
  }  
}
''');
    }
    code.line();
    code.write('''
@override
void dispose() {
  super.dispose();
  _changeNotifier.dispose();
}
''');
    code.closeIndent();
    code.write('}');

    // print('ModelBuilder.builder ->\n${code.toString()}');
    return code.toString();
  }

  static String _buildField(FieldElement field) {
    return '''
@override
set ${field.name}(${field.type} value) {
  super.${field.name} = value;
  _changeNotifier.notifyListeners();
}
    ''';
  }

  static String getConstructorName(String name) => '_\$$name';
}
