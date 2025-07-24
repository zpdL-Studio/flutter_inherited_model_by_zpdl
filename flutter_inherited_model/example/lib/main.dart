import 'package:flutter/material.dart';
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'main.g.dart';

void main() {
  runApp(const MyApp());
}

@FlutterInheritedModel(
  name: 'MyAppCountInheritedModel',
  useLifecycleState: true,
  useAsyncWorker: true,
  useSingleTickerProvider: true,
  // useTickerProvider: true,
  event: MyAppCountModelEvent,
)
class MyAppCountModel with $MyAppCountModel {
  @inheritedModelState
  late int count;

  MyAppCountModel._();

  factory MyAppCountModel({required String title}) = _$MyAppCountModel;

  @override
  void onInitState() {
    count = 0;
    onSnackBar('MyAppCountModel initState : ');
    asyncWorker(() async {});
  }

  // @override
  // void onDidUpdateWidget(String title) {
  //   super.onDidUpdateWidget(title);
  // }

  // @override
  // void onDispose() {
  //   super.onDispose();
  // }

  void onCountToZero() {
    count = 0;
  }

  void onSnackBar(String message) async {
    debugPrint(
      'onSnackBar result: ${await emitEvent(MyAppCountModelSnackBarEvent(message))}',
    );
  }

  @override
  void onDidChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint(
      'didChangeAppLifecycleState state: $state)',
    );
  }
}

sealed class MyAppCountModelEvent {}

@FlutterInheritedModel(
  name: 'EmptyInheritedModel',
  useStateCycle: false
)
class EmptyModel with $EmptyModel {
  EmptyModel._();
}

class MyAppCountModelSnackBarEvent implements MyAppCountModelEvent {
  final String message;

  MyAppCountModelSnackBarEvent(this.message);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Inherited Model Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(
        builder: (context) {
          return MyAppCountInheritedModel(
            title: 'Flutter Inherited Model Page',
            onEvent: (MyAppCountModel model, MyAppCountModelEvent event) async {
              switch (event) {
                case MyAppCountModelSnackBarEvent():
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(event.message)));
                  return true;
              }
            },
            child: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = MyAppCountInheritedModel.model(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(MyAppCountInheritedModel.titleOf(context)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Builder(
              builder: (context) {
                return Text(
                  '${MyAppCountInheritedModel.countOf(context)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                model.onCountToZero();
                model.onSnackBar('Count to zero');
              },
              child: Text('Count to zero'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model.count = model.count + 1;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
