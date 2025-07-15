// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// Generator: FlutterInheritedModelBuilder
// **************************************************************************

class MyAppInheritedModel extends StatefulWidget {
  static MyAppModel read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_MyAppInheritedModel>()!.model;
  }

  static int countOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppInheritedModel>(
      context,
      aspect: 0,
    )!.count;
  }

  static int countConstructOf(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppInheritedModel>(
      context,
      aspect: 1,
    )!.countConstruct;
  }

  static int? intConstruct3Of(BuildContext context) {
    return InheritedModel.inheritFrom<_MyAppInheritedModel>(
      context,
      aspect: 2,
    )!.intConstruct3;
  }

  const MyAppInheritedModel({
    super.key,
    required this.countConstruct,
    required this.stringConstruct1,
    this.stringConstruct2 = '123',
    this.stringConstruct3,
    required this.intConstruct1,
    this.intConstruct2 = 123,
    this.intConstruct3,
    required this.child,
  });

  final int countConstruct;
  final String stringConstruct1;
  final String stringConstruct2;
  final String? stringConstruct3;
  final int intConstruct1;
  final int intConstruct2;
  final int? intConstruct3;
  final Widget child;

  @override
  State<MyAppInheritedModel> createState() => _MyAppInheritedModelState();
}

class _$MyAppModel extends MyAppModel {
  _$MyAppModel({
    required super.countConstruct,
    required super.stringConstruct1,
    super.stringConstruct2 = '123',
    super.stringConstruct3,
    required super.intConstruct1,
    super.intConstruct2 = 123,
    super.intConstruct3,
  });

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

  @override
  set countConstruct(int value) {
    final setState = _setState;
    if (setState == null) {
      super.countConstruct = value;
      return;
    }
    setState(() {
      super.countConstruct = value;
    });
  }

  @override
  set intConstruct3(int? value) {
    final setState = _setState;
    if (setState == null) {
      super.intConstruct3 = value;
      return;
    }
    setState(() {
      super.intConstruct3 = value;
    });
  }
}

class _MyAppInheritedModelState extends State<MyAppInheritedModel> {
  late final _$MyAppModel _model;

  @override
  void initState() {
    super.initState();
    _model = _$MyAppModel(
      countConstruct: widget.countConstruct,
      stringConstruct1: widget.stringConstruct1,
      stringConstruct2: widget.stringConstruct2,
      stringConstruct3: widget.stringConstruct3,
      intConstruct1: widget.intConstruct1,
      intConstruct2: widget.intConstruct2,
      intConstruct3: widget.intConstruct3,
    );
    _model._setState = setState;
  }

  @override
  void dispose() {
    _model._setState = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _MyAppInheritedModel(
      count: _model.count,
      countConstruct: _model.countConstruct,
      intConstruct3: _model.intConstruct3,
      model: _model,
      child: widget.child,
    );
  }
}

class _MyAppInheritedModel extends InheritedModel<int> {
  final int count;
  final int countConstruct;
  final int? intConstruct3;
  final MyAppModel model;

  const _MyAppInheritedModel({
    required this.count,
    required this.countConstruct,
    required this.intConstruct3,
    required this.model,
    required super.child,
  });

  @override
  bool updateShouldNotify(_MyAppInheritedModel oldWidget) {
    return count != oldWidget.count ||
        countConstruct != oldWidget.countConstruct ||
        intConstruct3 != oldWidget.intConstruct3;
  }

  @override
  bool updateShouldNotifyDependent(
    _MyAppInheritedModel oldWidget,
    Set<int> dependencies,
  ) {
    if (count != oldWidget.count && dependencies.contains(0)) {
      return true;
    }

    if (countConstruct != oldWidget.countConstruct &&
        dependencies.contains(1)) {
      return true;
    }

    if (intConstruct3 != oldWidget.intConstruct3 && dependencies.contains(2)) {
      return true;
    }

    return false;
  }
}
