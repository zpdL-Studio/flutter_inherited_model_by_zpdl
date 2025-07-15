import 'package:flutter/material.dart';
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'main.g.dart';

void main() {
  runApp(const MyApp());
}

@FlutterInheritedModel(name: 'MyAppInheritedModel')
class MyAppModel with FlutterInheritedModelLifeCycle {
  final String title;
  @inheritedModelState
  late int count;

  MyAppModel({required this.title});

  @override
  void onInit() {
    count = 0;
  }

  void onIncrement() {
    count = count + 1;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyAppInheritedModel(
        title: 'Flutter Demo Home Page',
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = MyAppInheritedModel.read(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(model.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Builder(
              builder: (context) {
                return Text(
                  '${MyAppInheritedModel.countOf(context)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: model.onIncrement,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
