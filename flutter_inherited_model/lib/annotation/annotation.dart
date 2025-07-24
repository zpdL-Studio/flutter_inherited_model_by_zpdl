final class FlutterInheritedModel {
  final String? name;
  final bool useStateCycle;
  final bool useLifecycleState;
  final bool useAsyncWorker;
  final bool useSingleTickerProvider;
  final bool useTickerProvider;
  final Type? event;

  const FlutterInheritedModel({
    this.name,
    this.useStateCycle = true,
    this.useLifecycleState = false,
    this.useAsyncWorker = false,
    this.useSingleTickerProvider = false,
    this.useTickerProvider = false,
    this.event,
  });
}

final class InheritedModelState {
  const InheritedModelState();
}

const inheritedModelState = InheritedModelState();
