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
  // ignore: unused_field
  StateSetter? _$setState;

  String _$title;

  _$MyAppCountModel({required String title}) : _$title = title, super._();

  @override
  String get title => _$title;

  @override
  set count(int value) {
    final setState = _$setState;
    if (setState == null) {
      super.count = value;
      return;
    }
    setState(() {
      super.count = value;
    });
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
      model: _model,
      child: widget.child,
    );
  }
}

class _MyAppCountInheritedModel extends InheritedModel<int> {
  final String title;
  final int count;
  final _$MyAppCountModel model;

  const _MyAppCountInheritedModel({
    required this.title,
    required this.count,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_MyAppCountInheritedModel oldWidget) {
    return title != oldWidget.title || count != oldWidget.count;
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
    return false;
  }
}

mixin $EmptyModel {}

class EmptyInheritedModel extends StatefulWidget {
  static EmptyModel model(BuildContext context) {
    return maybeModel(context)!;
  }

  static EmptyModel? maybeModel(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_EmptyInheritedModel>()?.model;
  }

  const EmptyInheritedModel({super.key, required this.child});

  final Widget child;

  @override
  State<EmptyInheritedModel> createState() => _EmptyInheritedModelState();
}

class _$EmptyModel extends EmptyModel {
  // ignore: unused_field
  StateSetter? _$setState;

  _$EmptyModel() : super._();
}

class _EmptyInheritedModelState extends State<EmptyInheritedModel> {
  late final _$EmptyModel _model;

  @override
  void initState() {
    super.initState();
    _model = _$EmptyModel();
    _model._$setState = setState;
  }

  @override
  void dispose() {
    _model._$setState = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _EmptyInheritedModel(model: _model, child: widget.child);
  }
}

class _EmptyInheritedModel extends InheritedModel<int> {
  final _$EmptyModel model;

  const _EmptyInheritedModel({required this.model, required super.child});

  @override
  bool updateShouldNotify(_EmptyInheritedModel oldWidget) {
    return false;
  }

  @override
  bool updateShouldNotifyDependent(
    _EmptyInheritedModel oldWidget,
    Set<int> dependencies,
  ) {
    return false;
  }
}
