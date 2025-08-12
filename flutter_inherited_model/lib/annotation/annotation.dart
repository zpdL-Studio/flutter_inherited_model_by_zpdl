final class FlutterInheritedModel {
  final String? name;
  final bool useLifecycleState;
  final bool useAsyncWorker;
  final bool useSingleTickerProvider;
  final bool useTickerProvider;
  final Type? event;

  const FlutterInheritedModel({
    this.name,
    this.useLifecycleState = false,
    this.useAsyncWorker = false,
    this.useSingleTickerProvider = false,
    this.useTickerProvider = false,
    this.event,
  });
}

final class FlutterInheritedState {
  final String? name;
  final bool useAsyncWorker;

  const FlutterInheritedState({
    this.name,
    this.useAsyncWorker = false,
  });
}

final class InheritedModelState {
  const InheritedModelState();
}

const inheritedModelState = InheritedModelState();
