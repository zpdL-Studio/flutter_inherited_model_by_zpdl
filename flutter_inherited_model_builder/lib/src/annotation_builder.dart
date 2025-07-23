import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

class AnnotationBuilder {
  static AnnotationInfo getAnnotationInfo(ConstantReader annotation) {
    final name = annotation.read('name');
    final useStateCycle = annotation.read('useStateCycle');
    final event = annotation.read('event');
    return AnnotationInfo(
      name: name.isString ? name.stringValue : null,
      useStateCycle: useStateCycle.isBool ? useStateCycle.boolValue : false,
      event: event.isNull ? null : event.typeValue,
    );
  }
}

class AnnotationInfo {
  final String? name;
  final bool useStateCycle;
  final DartType? event;

  AnnotationInfo({
    required this.name,
    required this.useStateCycle,
    required this.event,
  });

  @override
  String toString() {
    return 'AnnotationInfo{name: $name, useStateCycle: $useStateCycle, event: $event}';
  }
}
