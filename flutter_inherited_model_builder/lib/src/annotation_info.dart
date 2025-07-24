import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

class AnnotationInfo {
  final String? name;
  final bool useStateCycle;
  final bool useLifecycleState;
  final DartType? event;

  AnnotationInfo({
    required this.name,
    required this.useStateCycle,
    required this.useLifecycleState,
    required this.event,
  });

  factory AnnotationInfo.from(ConstantReader annotation) {
    final name = annotation.read('name');
    final useStateCycle = annotation.read('useStateCycle');
    final useLifecycleState = annotation.read('useLifecycleState');
    final event = annotation.read('event');
    return AnnotationInfo(
      name: name.isString ? name.stringValue : null,
      useStateCycle: useStateCycle.isBool ? useStateCycle.boolValue : false,
      useLifecycleState:
          useLifecycleState.isBool ? useLifecycleState.boolValue : false,
      event: event.isNull ? null : event.typeValue,
    );
  }
  @override
  String toString() {
    return 'AnnotationInfo{name: $name, useStateCycle: $useStateCycle, useLifecycleState: $useLifecycleState, event: $event}';
  }
}
