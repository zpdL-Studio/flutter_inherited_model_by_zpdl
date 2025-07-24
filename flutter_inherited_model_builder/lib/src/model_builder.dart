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
    code.write('// ignore: unused_field');
    code.write('StateSetter? _\$setState;');
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

//     code.write('''
// @override
// void dispose() {
//   ${annotation.event != null ? '_\$event.dispose();' : ''}
//   super.dispose();
// }
// ''');

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

    code.closeIndent();
    code.write('}');

    // print('ModelBuilder.builder ->\n${code.toString()}');
    return code.toString();
  }

  static String _buildField(FieldElement field) {
    return '''
@override
set ${field.name}(${field.type} value) {
  final setState = _\$setState;
  if (setState == null) {
    super.${field.name} = value;
    return;
  }
  setState(() {
    super.${field.name} = value;
  });
}
    ''';
  }

  static String getConstructorName(String name) => '_\$$name';
}
