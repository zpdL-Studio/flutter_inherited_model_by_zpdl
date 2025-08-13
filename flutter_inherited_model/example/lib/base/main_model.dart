import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'main_model.g.dart';

@FlutterInheritedModel(
  name: 'MainInheritedModel',
  event: MainModelEvent,
)
class MainModel with $MainModel {
  MainModel._();
  factory MainModel() = _$MainModel;

  @inheritedModelState
  late int count;

  @override
  void onInitState() {
    super.onInitState();
    count = 0;
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
    super.onDispose();
  }

  void onIncrement() {
    count++;
  }

  void onShowSnapBar(String message) {
    emitEvent(MainModelSnackBarEvent(message));
  }
}

sealed class MainModelEvent {}

class MainModelSnackBarEvent implements MainModelEvent {
  final String message;

  MainModelSnackBarEvent(this.message);
}