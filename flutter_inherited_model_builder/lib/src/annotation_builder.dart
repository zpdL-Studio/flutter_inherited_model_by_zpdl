import 'package:source_gen/source_gen.dart';

class AnnotationBuilder {
  static AnnotationInfo getAnnotationInfo(ConstantReader annotation) {
    final name = annotation.read('name');
    final useStateCycle = annotation.read('useStateCycle');

    return AnnotationInfo(
      name: name.isString ? name.stringValue : null,
      useStateCycle: useStateCycle.isBool ? useStateCycle.boolValue : false,
    );
  }
}

class AnnotationInfo {
  final String? name;
  final bool useStateCycle;

  AnnotationInfo({required this.name, required this.useStateCycle});

  @override
  String toString() {
    return 'AnnotationInfo{name: $name, useStateCycle: $useStateCycle}';
  }
}
