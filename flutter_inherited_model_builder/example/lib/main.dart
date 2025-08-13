import 'package:flutter/material.dart';
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'main.g.dart';

void main() {
  runApp(const MyApp());
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
      home: MainPage(),
    );
  }
}

@FlutterInheritedModel(
  name: 'MainInheritedModel',
  useLifecycleState: true,
  useAsyncWorker: true,
  event: MainModelEvent,
)
class MainModel with $MainModel {
  @inheritedModelState
  late int count;

  final homeState = HomeState();

  MainModel._();

  factory MainModel({required String title}) = _$MainModel;

  @override
  void onInitState() {
    count = 0;
    onSnackBar('MainModel onInitState');
  }

  @override
  void onDispose() {
    homeState.dispose();
    super.onDispose();
  }

  void onCountToZero() {
    count = 0;
    homeState.count = 0;
  }

  void onSnackBar(String message) async {
    debugPrint(
      'onSnackBar result: ${await emitEvent(MainModelSnackBarEvent(message))}',
    );
  }

  @override
  void onDidChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('didChangeAppLifecycleState state: $state)');
  }
}

sealed class MainModelEvent {}

class MainModelSnackBarEvent implements MainModelEvent {
  final String message;

  MainModelSnackBarEvent(this.message);
}

@FlutterInheritedState(name: 'HomeInheritedState')
class HomeState with $HomeState {
  @inheritedModelState
  int count = 0;

  HomeState._();

  factory HomeState() = _$HomeState;

  @override
  void onAttachState() {
    super.onAttachState();
    debugPrint('HomeState onAttachState');
  }

  @override
  void onDetachState() {
    debugPrint('HomeState onDetachState');
    super.onDetachState();
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainInheritedModel(
      title: 'Flutter Inherited Model Page',
      onEvent: (MainModel model, MainModelEvent event) async {
        switch (event) {
          case MainModelSnackBarEvent():
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(event.message)));
            return true;
        }
      },
      child: _MainPage(),
    );
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Builder(
          builder: (context) {
            return Text(MainInheritedModel.titleOf(context));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Builder(
              builder: (context) {
                return Text(
                  '${MainInheritedModel.countOf(context)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 16),
            HomeInheritedState(
              value: MainInheritedModel.model(context).homeState,
              child: Builder(
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Home Count : ${HomeInheritedState.countOf(context)}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${HomeInheritedState.countOf(context)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          HomeInheritedState.model(context).count++;
                        },
                        child: Text('Increase home count'),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                MainInheritedModel.model(context).onCountToZero();
                MainInheritedModel.model(context).onSnackBar('Count to zero');
              },
              child: Text('Count to zero'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MainInheritedModel.model(context).count++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
