// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_model.dart';

// **************************************************************************
// Generator: FlutterInheritedModelBuilder
// **************************************************************************

mixin $MainModel {
  void onInitState() {}

  void onDidUpdateWidget() {}

  void onDispose() {}

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

  static int countOf(BuildContext context) => maybeCountOf(context)!;

  static int? maybeCountOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MainInheritedModel>(
      context,
      aspect: 0,
    )?.count;
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
      model: _model,
      child: widget.child,
    );
  }
}

class _MainInheritedModel extends InheritedModel<int> {
  final int count;
  final _$MainModel model;

  const _MainInheritedModel({
    required this.count,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_MainInheritedModel oldWidget) {
    return count != oldWidget.count;
  }

  @override
  bool updateShouldNotifyDependent(
    _MainInheritedModel oldWidget,
    Set<int> dependencies,
  ) {
    if (dependencies.contains(0) && count != oldWidget.count) {
      return true;
    }
    return false;
  }
}
