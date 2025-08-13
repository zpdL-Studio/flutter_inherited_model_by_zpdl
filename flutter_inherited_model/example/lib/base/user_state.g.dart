// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// Generator: FlutterInheritedStateBuilder
// **************************************************************************

mixin $UserState {
  void onAttachState() {}

  void onDetachState() {}

  void dispose() {}
}

class UserInheritedState extends StatefulWidget {
  static UserState model(BuildContext context) {
    return maybeModel(context)!;
  }

  static UserState? maybeModel(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_UserInheritedState>()?.model;
  }

  static String nameOf(BuildContext context) => maybeNameOf(context)!;

  static String? maybeNameOf(BuildContext context) {
    return InheritedModel.inheritFrom<_UserInheritedState>(
      context,
      aspect: 0,
    )?.name;
  }

  static int ageOf(BuildContext context) => maybeAgeOf(context)!;

  static int? maybeAgeOf(BuildContext context) {
    return InheritedModel.inheritFrom<_UserInheritedState>(
      context,
      aspect: 1,
    )?.age;
  }

  const UserInheritedState({
    super.key,
    required this.state,
    required this.child,
  }) : assert(state is _$UserState);

  final UserState state;
  final Widget child;

  @override
  State<UserInheritedState> createState() => _UserInheritedStateState();
}

class _$UserStateChangeNotifier with ChangeNotifier {
  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }
}

class _$UserState extends UserState {
  final _changeNotifier = _$UserStateChangeNotifier();

  _$UserState() : super._();

  @override
  set name(String value) {
    super.name = value;
    _changeNotifier.notifyListeners();
  }

  @override
  set age(int value) {
    super.age = value;
    _changeNotifier.notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _changeNotifier.dispose();
  }
}

class _UserInheritedStateState extends State<UserInheritedState> {
  late _$UserState _model;

  @override
  void initState() {
    super.initState();
    _model = widget.state as _$UserState;
    _model.onAttachState();
    _model._changeNotifier.addListener(_updateValue);
  }

  @override
  void didUpdateWidget(UserInheritedState oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_model != widget.state) {
      _model._changeNotifier.removeListener(_updateValue);
      _model.onDetachState();
      _model = widget.state as _$UserState;
      _model.onAttachState();
      _model._changeNotifier.addListener(_updateValue);
    }
  }

  @override
  void dispose() {
    _model._changeNotifier.removeListener(_updateValue);
    _model.onDetachState();
    super.dispose();
  }

  void _updateValue() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _UserInheritedState(
      name: _model.name,
      age: _model.age,
      model: _model,
      child: widget.child,
    );
  }
}

class _UserInheritedState extends InheritedModel<int> {
  final String name;
  final int age;
  final _$UserState model;

  const _UserInheritedState({
    required this.name,
    required this.age,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_UserInheritedState oldWidget) {
    return name != oldWidget.name || age != oldWidget.age;
  }

  @override
  bool updateShouldNotifyDependent(
    _UserInheritedState oldWidget,
    Set<int> dependencies,
  ) {
    if (dependencies.contains(0) && name != oldWidget.name) {
      return true;
    }
    if (dependencies.contains(1) && age != oldWidget.age) {
      return true;
    }
    return false;
  }
}
