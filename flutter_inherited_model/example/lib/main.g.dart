// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// Generator: FlutterInheritedModelBuilder
// **************************************************************************

mixin $MyAppCountModel {
  String get title =>
      throw UnimplementedError('title has not been implemented.');

  void initState() {}

  void didUpdateWidget(String title) {}

  void dispose() {}

  Future<dynamic> emitEvent(MyAppCountModelEvent event) =>
      throw UnimplementedError(
        'emitEvent(MyAppCountModelEvent event) has not been implemented.',
      );
}

class MyAppCountInheritedModel extends StatefulWidget {
  static MyAppCountModel model(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<_MyAppCountInheritedModel>()!
        .model;
  }

  static MyAppCountModel? maybeModel(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<_MyAppCountInheritedModel>()
        ?.model;
  }

  static String titleOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppCountInheritedModel>(
      context,
      aspect: 0,
    )!.title;
  }

  static String? maybeTitleOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppCountInheritedModel>(
      context,
      aspect: 0,
    )?.title;
  }

  static int countOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppCountInheritedModel>(
      context,
      aspect: 1,
    )!.count;
  }

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

    _model.initState();
    _model._$setState = setState;
  }

  @override
  void didUpdateWidget(MyAppCountInheritedModel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.title != oldWidget.title) {
      _model.didUpdateWidget(widget.title);
      _model._$title = widget.title;
    }
  }

  @override
  void dispose() {
    _model._$event = null;
    _model._$setState = null;
    _model.dispose();
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

mixin $MyAppCountModel2 {
  void initState() {}

  void didUpdateWidget() {}

  void dispose() {}
}

class MyAppCount2InheritedModel extends StatefulWidget {
  static MyAppCountModel2 model(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<_MyAppCount2InheritedModel>()!
        .model;
  }

  static MyAppCountModel2? maybeModel(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<_MyAppCount2InheritedModel>()
        ?.model;
  }

  const MyAppCount2InheritedModel({super.key, required this.child});

  final Widget child;

  @override
  State<MyAppCount2InheritedModel> createState() =>
      _MyAppCount2InheritedModelState();
}

class _$MyAppCountModel2 extends MyAppCountModel2 {
  StateSetter? _$setState;

  _$MyAppCountModel2() : super._();
}

class _MyAppCount2InheritedModelState extends State<MyAppCount2InheritedModel> {
  late final _$MyAppCountModel2 _model;
  bool _isFrameDraw = false;

  @override
  void initState() {
    super.initState();
    _model = _$MyAppCountModel2();
    _model.initState();
    _model._$setState = setState;
  }

  @override
  void dispose() {
    _model._$setState = null;
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isFrameDraw = true;
    return _MyAppCount2InheritedModel(model: _model, child: widget.child);
  }
}

class _MyAppCount2InheritedModel extends InheritedModel<int> {
  final _$MyAppCountModel2 model;

  const _MyAppCount2InheritedModel({required this.model, required super.child});

  @override
  bool updateShouldNotify(_MyAppCount2InheritedModel oldWidget) {
    return false;
  }

  @override
  bool updateShouldNotifyDependent(
    _MyAppCount2InheritedModel oldWidget,
    Set<int> dependencies,
  ) {
    return false;
  }
}
