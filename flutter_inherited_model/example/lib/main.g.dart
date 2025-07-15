// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// Generator: FlutterInheritedModelBuilder
// **************************************************************************

class MyAppInheritedModel extends StatefulWidget {
  static MyAppModel read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_MyAppInheritedModel>()!.model;
  }

  static MyAppModel? maybeRead(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_MyAppInheritedModel>()?.model;
  }

  static int countOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppInheritedModel>(
      context,
      aspect: 0,
    )!.count;
  }

  static int? maybeCountOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppInheritedModel>(
      context,
      aspect: 0,
    )?.count;
  }

  const MyAppInheritedModel({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  State<MyAppInheritedModel> createState() => _MyAppInheritedModelState();
}

class _$MyAppModel extends MyAppModel {
  _$MyAppModel({required super.title});

  StateSetter? _setState;

  @override
  set count(int value) {
    final setState = _setState;
    if (setState == null) {
      super.count = value;
      return;
    }
    setState(() {
      super.count = value;
    });
  }
}

class _MyAppInheritedModelState extends State<MyAppInheritedModel> {
  late final _$MyAppModel _model;

  @override
  void initState() {
    super.initState();
    _model = _$MyAppModel(title: widget.title);
    _model.onInit();
    _model._setState = setState;
  }

  @override
  void dispose() {
    _model._setState = null;
    _model.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _MyAppInheritedModel(
      count: _model.count,
      model: _model,
      child: widget.child,
    );
  }
}

class _MyAppInheritedModel extends InheritedModel<int> {
  final int count;
  final MyAppModel model;

  const _MyAppInheritedModel({
    required this.count,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_MyAppInheritedModel oldWidget) {
    return count != oldWidget.count;
  }

  @override
  bool updateShouldNotifyDependent(
    _MyAppInheritedModel oldWidget,
    Set<int> dependencies,
  ) {
    if (count != oldWidget.count && dependencies.contains(0)) {
      return true;
    }

    return false;
  }
}
