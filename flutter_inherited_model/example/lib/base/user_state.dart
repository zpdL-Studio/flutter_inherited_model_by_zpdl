import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'user_state.g.dart';

@FlutterInheritedState(name: 'UserInheritedState')
class UserState with $UserState {

  UserState._();

  factory UserState() = _$UserState;

  @inheritedModelState
  late String name;

  @inheritedModelState
  late int age;

  @override
  void onAttachState() {
    super.onAttachState();
    debugPrint('UserState onAttachState');
  }

  @override
  void onDetachState() {
    debugPrint('UserState onDetachState');
    super.onDetachState();
  }
}