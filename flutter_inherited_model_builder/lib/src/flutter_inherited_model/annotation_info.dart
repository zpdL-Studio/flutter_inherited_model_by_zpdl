import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

class AnnotationInfo {
  final String? name;
  final bool useLifecycleState;
  final bool useAsyncWorker;
  final bool useSingleTickerProvider;
  final bool useTickerProvider;
  final DartType? event;

  AnnotationInfo({
    required this.name,
    required this.useLifecycleState,
    required this.useAsyncWorker,
    required this.useSingleTickerProvider,
    required this.useTickerProvider,
    required this.event,
  });

  factory AnnotationInfo.from(ConstantReader annotation) {
    final name = annotation.read('name');
    final useLifecycleState = annotation.read('useLifecycleState');
    final useAsyncWorker = annotation.read('useAsyncWorker');
    final useSingleTickerProvider = annotation.read('useSingleTickerProvider');
    final useTickerProvider = annotation.read('useTickerProvider');
    final event = annotation.read('event');

    return AnnotationInfo(
      name: name.isString ? name.stringValue : null,
      useLifecycleState:
          useLifecycleState.isBool ? useLifecycleState.boolValue : false,
      useAsyncWorker: useAsyncWorker.isBool ? useAsyncWorker.boolValue : false,
      useSingleTickerProvider:
          useSingleTickerProvider.isBool
              ? useSingleTickerProvider.boolValue
              : false,
      useTickerProvider:
          useTickerProvider.isBool ? useTickerProvider.boolValue : false,
      event: event.isNull ? null : event.typeValue,
    );
  }

  @override
  String toString() {
    return 'AnnotationInfo{name: $name, useLifecycleState: $useLifecycleState, useAsyncWorker: $useAsyncWorker, useSingleTickerProvider: $useSingleTickerProvider, useTickerProvider: $useTickerProvider, event: $event}';
  }
}
