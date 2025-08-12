import 'package:source_gen/source_gen.dart';

class AnnotationInfo {
  final String? name;
  final bool useAsyncWorker;

  AnnotationInfo({required this.name, required this.useAsyncWorker});

  factory AnnotationInfo.from(ConstantReader annotation) {
    final name = annotation.read('name');
    final useAsyncWorker = annotation.read('useAsyncWorker');

    return AnnotationInfo(
      name: name.isString ? name.stringValue : null,
      useAsyncWorker: useAsyncWorker.isBool ? useAsyncWorker.boolValue : false,
    );
  }

  @override
  String toString() {
    return 'AnnotationInfo{name: $name, useAsyncWorker: $useAsyncWorker}';
  }
}
