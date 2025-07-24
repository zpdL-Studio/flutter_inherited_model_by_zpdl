final class FlutterInheritedModel {
  final String? name;
  final bool useStateCycle;
  final bool useLifecycleState;
  final bool useAsyncWorker;
  final Type? event;

  const FlutterInheritedModel({
    this.name,
    this.useStateCycle = true,
    this.useLifecycleState = false,
    this.useAsyncWorker = false,
    this.event,
  });
}

final class InheritedModelState {
  const InheritedModelState();
}

const inheritedModelState = InheritedModelState();
