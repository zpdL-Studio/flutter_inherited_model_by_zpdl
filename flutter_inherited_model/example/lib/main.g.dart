// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// Generator: FlutterInheritedModelBuilder
// **************************************************************************

mixin $MainModel {
  void onInitState() {}

  void onDidUpdateWidget() {}

  void onDispose() {}

  void Function(Object e, StackTrace stackTrace)? asyncWorkerDefaultError;

  void asyncWorker(
    Future<void> Function() worker, [
    void Function(Object e, StackTrace stackTrace)? error,
  ]) => throw UnimplementedError('asyncWorker has not been implemented.');

  Future<dynamic> emitEvent(MainModelEvent event) =>
      throw UnimplementedError(
        'emitEvent(MainModelEvent event) has not been implemented.',
      );
}

class MainInheritedModel extends StatefulWidget {
  static MainModel model(BuildContext context) {
    return maybeModel(context)!;
  }

  static MainModel? maybeModel(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_MainInheritedModel>()?.model;
  }

  static bool asyncWorkingOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MainInheritedModel>(
          context,
          aspect: 2,
        )?.asyncWorking ??
        false;
  }

  static int countOf(BuildContext context) => maybeCountOf(context)!;

  static int? maybeCountOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MainInheritedModel>(
      context,
      aspect: 0,
    )?.count;
  }

  static String dataOf(BuildContext context) => maybeDataOf(context)!;

  static String? maybeDataOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MainInheritedModel>(
      context,
      aspect: 1,
    )?.data;
  }

  const MainInheritedModel({super.key, this.onEvent, required this.child});

  final Future<dynamic> Function(MainModel model, MainModelEvent event)?
  onEvent;
  final Widget child;

  @override
  State<MainInheritedModel> createState() => _MainInheritedModelState();
}

class _$MainModel extends MainModel {
  StateSetter? _$setState;

  // ignore: unused_element
  void _setState(VoidCallback fn) {
    final setState = _$setState;
    if (setState == null) {
      fn();
      return;
    }
    setState(fn);
  }

  _$MainModel() : super._();

  @override
  set count(int value) {
    _setState(() => super.count = value);
  }

  @override
  set data(String value) {
    _setState(() => super.data = value);
  }

  int _$asyncWorkingCount = 0;

  bool get _asyncWorking => _$asyncWorkingCount > 0;

  @override
  void asyncWorker(
    Future<void> Function() worker, [
    void Function(Object e, StackTrace stackTrace)? error,
  ]) async {
    final asyncWorking = _asyncWorking;
    _$asyncWorkingCount++;
    if (_asyncWorking != asyncWorking) {
      try {
        _setState(() {});
      } catch (_) {}
    }
    try {
      await worker();
    } catch (e, stackTrace) {
      (error ?? asyncWorkerDefaultError)?.call(e, stackTrace);
    } finally {
      final asyncWorking = _asyncWorking;
      _$asyncWorkingCount--;
      if (_asyncWorking != asyncWorking) {
        try {
          _setState(() {});
        } catch (_) {}
      }
    }
  }

  Future<dynamic> Function(MainModelEvent)? _$event;

  @override
  Future<dynamic> emitEvent(MainModelEvent event) async {
    return await _$event?.call(event);
  }
}

class _MainInheritedModelState extends State<MainInheritedModel> {
  late final _$MainModel _model;
  bool _isFrameDraw = false;

  @override
  void initState() {
    super.initState();
    _model = _$MainModel();
    _model._$event = (e) async {
      final onEvent = widget.onEvent;
      if (onEvent != null) {
        if (!_isFrameDraw) {
          final completer = Completer<dynamic>();
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            try {
              completer.complete(await onEvent(_model, e));
            } catch (e) {
              completer.completeError(e);
            }
          });
          return completer.future;
        } else {
          return await onEvent(_model, e);
        }
      }
      return null;
    };

    _model.onInitState();
    _model._$setState = setState;
  }

  @override
  void dispose() {
    _model._$event = null;
    _model._$setState = null;
    _model.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isFrameDraw = true;
    return _MainInheritedModel(
      count: _model.count,
      data: _model.data,
      asyncWorking: _model._asyncWorking,
      model: _model,
      child: widget.child,
    );
  }
}

class _MainInheritedModel extends InheritedModel<int> {
  final int count;
  final String data;
  final bool asyncWorking;
  final _$MainModel model;

  const _MainInheritedModel({
    required this.count,
    required this.data,
    required this.asyncWorking,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_MainInheritedModel oldWidget) {
    return count != oldWidget.count ||
        data != oldWidget.data ||
        asyncWorking != oldWidget.asyncWorking;
  }

  @override
  bool updateShouldNotifyDependent(
    _MainInheritedModel oldWidget,
    Set<int> dependencies,
  ) {
    if (dependencies.contains(0) && count != oldWidget.count) {
      return true;
    }
    if (dependencies.contains(1) && data != oldWidget.data) {
      return true;
    }
    if (dependencies.contains(2) && asyncWorking != oldWidget.asyncWorking) {
      return true;
    }
    return false;
  }
}

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
