// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_example.dart';

// **************************************************************************
// Generator: FlutterInheritedModelBuilder
// **************************************************************************

mixin $MainModel {
  void onInitState() {}

  void onDidUpdateWidget() {}

  void onDispose() {}

  Future<dynamic> emitEvent(MainTapModelEvent event) =>
      throw UnimplementedError(
        'emitEvent(MainTapModelEvent event) has not been implemented.',
      );

  TickerProvider get tickerProvider =>
      throw UnimplementedError('tickerProvider has not been implemented.');
}

class MainInheritedModel extends StatefulWidget {
  static MainModel model(BuildContext context) {
    return maybeModel(context)!;
  }

  static MainModel? maybeModel(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_MainInheritedModel>()?.model;
  }

  static ShoppingState shoppingStateOf(BuildContext context) =>
      maybeShoppingStateOf(context)!;

  static ShoppingState? maybeShoppingStateOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MainInheritedModel>(
      context,
      aspect: 0,
    )?.shoppingState;
  }

  static int tabIndexOf(BuildContext context) => maybeTabIndexOf(context)!;

  static int? maybeTabIndexOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MainInheritedModel>(
      context,
      aspect: 1,
    )?.tabIndex;
  }

  const MainInheritedModel({super.key, this.onEvent, required this.child});

  final Future<dynamic> Function(MainModel model, MainTapModelEvent event)?
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
  set shoppingState(ShoppingState value) {
    _setState(() => super.shoppingState = value);
  }

  @override
  set tabIndex(int value) {
    _setState(() => super.tabIndex = value);
  }

  Future<dynamic> Function(MainTapModelEvent)? _$event;

  @override
  Future<dynamic> emitEvent(MainTapModelEvent event) async {
    return await _$event?.call(event);
  }

  late final TickerProvider Function() _$tickerProvider;

  @override
  TickerProvider get tickerProvider => _$tickerProvider();
}

class _MainInheritedModelState extends State<MainInheritedModel>
    with SingleTickerProviderStateMixin {
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

    _model._$tickerProvider = () => this;

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
      shoppingState: _model.shoppingState,
      tabIndex: _model.tabIndex,
      model: _model,
      child: widget.child,
    );
  }
}

class _MainInheritedModel extends InheritedModel<int> {
  final ShoppingState shoppingState;
  final int tabIndex;
  final _$MainModel model;

  const _MainInheritedModel({
    required this.shoppingState,
    required this.tabIndex,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_MainInheritedModel oldWidget) {
    return shoppingState != oldWidget.shoppingState ||
        tabIndex != oldWidget.tabIndex;
  }

  @override
  bool updateShouldNotifyDependent(
    _MainInheritedModel oldWidget,
    Set<int> dependencies,
  ) {
    if (dependencies.contains(0) && shoppingState != oldWidget.shoppingState) {
      return true;
    }
    if (dependencies.contains(1) && tabIndex != oldWidget.tabIndex) {
      return true;
    }
    return false;
  }
}

// **************************************************************************
// Generator: FlutterInheritedStateBuilder
// **************************************************************************

mixin $HomeState {
  String get title =>
      throw UnimplementedError('title has not been implemented.');

  void onAttachState() {}

  void onDetachState() {}

  void dispose() {}

  void Function(Object e, StackTrace stackTrace)? asyncWorkerDefaultError;

  void asyncWorker(
    Future<void> Function() worker, [
    void Function(Object e, StackTrace stackTrace)? error,
  ]) => throw UnimplementedError('asyncWorker has not been implemented.');
}

class HomeInheritedState extends StatefulWidget {
  static HomeState model(BuildContext context) {
    return maybeModel(context)!;
  }

  static HomeState? maybeModel(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_HomeInheritedState>()?.model;
  }

  static bool asyncWorkingOf(BuildContext context) {
    return InheritedModel.inheritFrom<_HomeInheritedState>(
          context,
          aspect: 2,
        )?.asyncWorking ??
        false;
  }

  static String titleOf(BuildContext context) => maybeTitleOf(context)!;

  static String? maybeTitleOf(BuildContext context) {
    return InheritedModel.inheritFrom<_HomeInheritedState>(
      context,
      aspect: 0,
    )?.title;
  }

  static int countOf(BuildContext context) => maybeCountOf(context)!;

  static int? maybeCountOf(BuildContext context) {
    return InheritedModel.inheritFrom<_HomeInheritedState>(
      context,
      aspect: 1,
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

  final String _$title;

  _$HomeState({required String title}) : _$title = title, super._();

  @override
  String get title => _$title;

  @override
  set count(int value) {
    super.count = value;
    _changeNotifier.notifyListeners();
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
      _changeNotifier.notifyListeners();
    }
    try {
      await worker();
    } catch (e, stackTrace) {
      (error ?? asyncWorkerDefaultError)?.call(e, stackTrace);
    } finally {
      final asyncWorking = _asyncWorking;
      _$asyncWorkingCount--;
      if (_asyncWorking != asyncWorking) {
        _changeNotifier.notifyListeners();
      }
    }
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
      title: _model.title,
      count: _model.count,
      asyncWorking: _model._asyncWorking,
      model: _model,
      child: widget.child,
    );
  }
}

class _HomeInheritedState extends InheritedModel<int> {
  final String title;
  final int count;
  final bool asyncWorking;
  final _$HomeState model;

  const _HomeInheritedState({
    required this.title,
    required this.count,
    required this.asyncWorking,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_HomeInheritedState oldWidget) {
    return title != oldWidget.title ||
        count != oldWidget.count ||
        asyncWorking != oldWidget.asyncWorking;
  }

  @override
  bool updateShouldNotifyDependent(
    _HomeInheritedState oldWidget,
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

mixin $ShoppingState {
  String get title =>
      throw UnimplementedError('title has not been implemented.');

  void onAttachState() {}

  void onDetachState() {}

  void dispose() {}
}

class ShoppingInheritedState extends StatefulWidget {
  static ShoppingState model(BuildContext context) {
    return maybeModel(context)!;
  }

  static ShoppingState? maybeModel(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<_ShoppingInheritedState>()
        ?.model;
  }

  static String titleOf(BuildContext context) => maybeTitleOf(context)!;

  static String? maybeTitleOf(BuildContext context) {
    return InheritedModel.inheritFrom<_ShoppingInheritedState>(
      context,
      aspect: 0,
    )?.title;
  }

  static int countOf(BuildContext context) => maybeCountOf(context)!;

  static int? maybeCountOf(BuildContext context) {
    return InheritedModel.inheritFrom<_ShoppingInheritedState>(
      context,
      aspect: 1,
    )?.count;
  }

  const ShoppingInheritedState({
    super.key,
    required this.value,
    required this.child,
  }) : assert(value is _$ShoppingState);

  final ShoppingState value;
  final Widget child;

  @override
  State<ShoppingInheritedState> createState() => _ShoppingInheritedStateState();
}

class _$ShoppingStateChangeNotifier with ChangeNotifier {
  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }
}

class _$ShoppingState extends ShoppingState {
  final _changeNotifier = _$ShoppingStateChangeNotifier();

  final String _$title;

  _$ShoppingState({required String title}) : _$title = title, super._();

  @override
  String get title => _$title;

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

class _ShoppingInheritedStateState extends State<ShoppingInheritedState> {
  late _$ShoppingState _model;

  @override
  void initState() {
    super.initState();
    _model = widget.value as _$ShoppingState;
    _model.onAttachState();
    _model._changeNotifier.addListener(_updateValue);
  }

  @override
  void didUpdateWidget(ShoppingInheritedState oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_model != widget.value) {
      _model._changeNotifier.removeListener(_updateValue);
      _model.onDetachState();
      _model = widget.value as _$ShoppingState;
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
    return _ShoppingInheritedState(
      title: _model.title,
      count: _model.count,
      model: _model,
      child: widget.child,
    );
  }
}

class _ShoppingInheritedState extends InheritedModel<int> {
  final String title;
  final int count;
  final _$ShoppingState model;

  const _ShoppingInheritedState({
    required this.title,
    required this.count,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_ShoppingInheritedState oldWidget) {
    return title != oldWidget.title || count != oldWidget.count;
  }

  @override
  bool updateShouldNotifyDependent(
    _ShoppingInheritedState oldWidget,
    Set<int> dependencies,
  ) {
    if (dependencies.contains(0) && title != oldWidget.title) {
      return true;
    }
    if (dependencies.contains(1) && count != oldWidget.count) {
      return true;
    }
    return false;
  }
}
