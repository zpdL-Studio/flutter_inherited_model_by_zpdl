// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// Generator: FlutterInheritedModelBuilder
// **************************************************************************

mixin $MyAppCountModel {
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

  Future<dynamic> emitEvent(MyAppCountModelEvent event) =>
      throw UnimplementedError(
        'emitEvent(MyAppCountModelEvent event) has not been implemented.',
      );
}

class MyAppCountInheritedModel extends StatefulWidget {
  static MyAppCountModel model(BuildContext context) {
    return maybeModel(context)!;
  }

  static MyAppCountModel? maybeModel(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<_MyAppCountInheritedModel>()
        ?.model;
  }

  static bool asyncWorkingOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppCountInheritedModel>(
          context,
          aspect: 2,
        )?.asyncWorking ??
        false;
  }

  static String titleOf(BuildContext context) => maybeTitleOf(context)!;

  static String? maybeTitleOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppCountInheritedModel>(
      context,
      aspect: 0,
    )?.title;
  }

  static int countOf(BuildContext context) => maybeCountOf(context)!;

  static int? maybeCountOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppCountInheritedModel>(
      context,
      aspect: 1,
    )?.count;
  }

  const MyAppCountInheritedModel({
    super.key,
    required this.title,
    this.onEvent,
    required this.child,
  });

  final String title;
  final Future<dynamic> Function(
    MyAppCountModel model,
    MyAppCountModelEvent event,
  )?
  onEvent;
  final Widget child;

  @override
  State<MyAppCountInheritedModel> createState() =>
      _MyAppCountInheritedModelState();
}

class _$MyAppCountModel extends MyAppCountModel {
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

  _$MyAppCountModel({required String title}) : _$title = title, super._();

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

  Future<dynamic> Function(MyAppCountModelEvent)? _$event;

  @override
  Future<dynamic> emitEvent(MyAppCountModelEvent event) async {
    return await _$event?.call(event);
  }
}

class _MyAppCountInheritedModelState extends State<MyAppCountInheritedModel> {
  late final _$MyAppCountModel _model;
  late final AppLifecycleListener _lifecycleStateListener;
  bool _isFrameDraw = false;

  @override
  void initState() {
    super.initState();
    _model = _$MyAppCountModel(title: widget.title);
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
  void didUpdateWidget(MyAppCountInheritedModel oldWidget) {
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
    return _MyAppCountInheritedModel(
      title: _model.title,
      count: _model.count,
      asyncWorking: _model._asyncWorking,
      model: _model,
      child: widget.child,
    );
  }
}

class _MyAppCountInheritedModel extends InheritedModel<int> {
  final String title;
  final int count;
  final bool asyncWorking;
  final _$MyAppCountModel model;

  const _MyAppCountInheritedModel({
    required this.title,
    required this.count,
    required this.asyncWorking,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_MyAppCountInheritedModel oldWidget) {
    return title != oldWidget.title ||
        count != oldWidget.count ||
        asyncWorking != oldWidget.asyncWorking;
  }

  @override
  bool updateShouldNotifyDependent(
    _MyAppCountInheritedModel oldWidget,
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
