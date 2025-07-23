// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// Generator: FlutterInheritedModelBuilder
// **************************************************************************

mixin $MyAppCountModel {
  String get title => throw UnimplementedError();

  void initState() {}

  void didUpdateWidget(String title) {}

  void dispose() {}
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
    required this.child,
  });

  final String title;
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
}

class _MyAppCountInheritedModelState extends State<MyAppCountInheritedModel> {
  late final _$MyAppCountModel _model;

  @override
  void initState() {
    super.initState();
    _model = _$MyAppCountModel(title: widget.title);
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
    _model._$setState = null;
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
