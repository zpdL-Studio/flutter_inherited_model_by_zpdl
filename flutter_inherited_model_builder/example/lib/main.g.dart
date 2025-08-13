// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// Generator: FlutterInheritedModelBuilder
// **************************************************************************

mixin $MainModel {
  String get title =>
      throw UnimplementedError('title has not been implemented.');

  void onInitState() {}

  void onDidUpdateWidget(String title) {}

  void onDispose() {}

  void onDidChangeAppLifecycleState(AppLifecycleState state) {}

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

  static String titleOf(BuildContext context) => maybeTitleOf(context)!;

  static String? maybeTitleOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MainInheritedModel>(
      context,
      aspect: 0,
    )?.title;
  }

  static int countOf(BuildContext context) => maybeCountOf(context)!;

  static int? maybeCountOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MainInheritedModel>(
      context,
      aspect: 1,
    )?.count;
  }

  const MainInheritedModel({
    super.key,
    required this.title,
    this.onEvent,
    required this.child,
  });

  final String title;
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

  String _$title;

  _$MainModel({required String title}) : _$title = title, super._();

  @override
  String get title => _$title;

  @override
  set count(int value) {
    _setState(() => super.count = value);
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
  late final AppLifecycleListener _lifecycleStateListener;
  bool _isFrameDraw = false;

  @override
  void initState() {
    super.initState();
    _model = _$MainModel(title: widget.title);
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
    _lifecycleStateListener = AppLifecycleListener(
      onStateChange: _model.onDidChangeAppLifecycleState,
    );
  }

  @override
  void didUpdateWidget(MainInheritedModel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.title != oldWidget.title) {
      _model.onDidUpdateWidget(widget.title);
      _model._$title = widget.title;
    }
  }

  @override
  void dispose() {
    _lifecycleStateListener.dispose();
    _model._$event = null;
    _model._$setState = null;
    _model.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isFrameDraw = true;
    return _MainInheritedModel(
      title: _model.title,
      count: _model.count,
      asyncWorking: _model._asyncWorking,
      model: _model,
      child: widget.child,
    );
  }
}

class _MainInheritedModel extends InheritedModel<int> {
  final String title;
  final int count;
  final bool asyncWorking;
  final _$MainModel model;

  const _MainInheritedModel({
    required this.title,
    required this.count,
    required this.asyncWorking,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_MainInheritedModel oldWidget) {
    return title != oldWidget.title ||
        count != oldWidget.count ||
        asyncWorking != oldWidget.asyncWorking;
  }

  @override
  bool updateShouldNotifyDependent(
    _MainInheritedModel oldWidget,
    Set<int> dependencies,
  ) {
    if (dependencies.contains(0) && title != oldWidget.title) {
      return true;
    }
    if (dependencies.contains(1) && count != oldWidget.count) {
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

mixin $HomeState {
  void onAttachState() {}

  void onDetachState() {}

  void dispose() {}
}

class HomeInheritedState extends StatefulWidget {
  static HomeState model(BuildContext context) {
    return maybeModel(context)!;
  }

  static HomeState? maybeModel(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_HomeInheritedState>()?.model;
  }

  static int countOf(BuildContext context) => maybeCountOf(context)!;

  static int? maybeCountOf(BuildContext context) {
    return InheritedModel.inheritFrom<_HomeInheritedState>(
      context,
      aspect: 0,
    )?.count;
  }

  const HomeInheritedState({
    super.key,
    required this.value,
    required this.child,
  }) : assert(value is _$HomeState);

  final HomeState value;
  final Widget child;

  @override
  State<HomeInheritedState> createState() => _HomeInheritedStateState();
}

class _$HomeStateChangeNotifier with ChangeNotifier {
  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }
}

class _$HomeState extends HomeState {
  final _changeNotifier = _$HomeStateChangeNotifier();

  _$HomeState() : super._();

  @override
  set count(int value) {
    super.count = value;
    _changeNotifier.notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _changeNotifier.dispose();
  }
}

class _HomeInheritedStateState extends State<HomeInheritedState> {
  late _$HomeState _model;

  @override
  void initState() {
    super.initState();
    _model = widget.value as _$HomeState;
    _model.onAttachState();
    _model._changeNotifier.addListener(_updateValue);
  }

  @override
  void didUpdateWidget(HomeInheritedState oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_model != widget.value) {
      _model._changeNotifier.removeListener(_updateValue);
      _model.onDetachState();
      _model = widget.value as _$HomeState;
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
    return _HomeInheritedState(
      count: _model.count,
      model: _model,
      child: widget.child,
    );
  }
}

class _HomeInheritedState extends InheritedModel<int> {
  final int count;
  final _$HomeState model;

  const _HomeInheritedState({
    required this.count,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_HomeInheritedState oldWidget) {
    return count != oldWidget.count;
  }

  @override
  bool updateShouldNotifyDependent(
    _HomeInheritedState oldWidget,
    Set<int> dependencies,
  ) {
    if (dependencies.contains(0) && count != oldWidget.count) {
      return true;
    }
    return false;
  }
}
