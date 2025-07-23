final class FlutterInheritedModel {
  final String? name;
  final bool useStateCycle;

  const FlutterInheritedModel({this.name, this.useStateCycle = true});
}

final class InheritedModelState {
  const InheritedModelState();
}

const inheritedModelState = InheritedModelState();
