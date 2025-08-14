# flutter_inherited_model

[![pub package](https://img.shields.io/pub/v/flutter_inherited_model.svg)](https://pub.dev/packages/flutter_inherited_model)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

ENGLISH | [한국어](https://github.com/zpdL-Studio/flutter_inherited_model_by_zpdl/blob/main/flutter_inherited_model/README.ko-kr.md)

A state management package that helps you easily use Flutter's `InheritedModel` based on code generation.

You can leverage the powerful features of `InheritedModel` with simple annotation (@) usage without complex setup, and optimize app performance by rebuilding only the necessary widgets according to state changes.

This package must be used with `flutter_inherited_model_builder`.

## Key Features

- **Concise Syntax**: Automatically generates an `InheritedModel` widget with a single `@FlutterInheritedModel` annotation.
- **Performance Optimization**: Automatically detects state fields and rebuilds only the widgets that depend on a specific state.
- **Granular State Management**: You can define and manage another sub-state within the model using `@FlutterInheritedState`. This allows you to organize and separate complex state logic more systematically.
- **Lifecycle Management**: You can directly manage widget lifecycle events such as `onInitState`, `onDispose`, and `onDidChangeAppLifecycleState` within the model class.
- **Event Handling**: You can easily handle interactions between the model and the UI (e.g., showing a SnackBar, navigating pages) through the `Event` system.
- **Asynchronous Task Support**: You can safely perform asynchronous tasks within the model with the `useAsyncWorker` option.

## Installation

Add the following dependencies to your `pubspec.yaml` file.

```yaml
dependencies:
  flutter_inherited_model: ^0.9.5 # Please check the latest version on pub.dev.

dev_dependencies:
  flutter_inherited_model_builder: ^0.9.5 # Please check the latest version.
  build_runner: ^2.5.4 # The build_runner version may be adjusted for compatibility.
```

## Basic Usage

### 1. Create a Model Class

Create a class to manage the state and add the `@FlutterInheritedModel` annotation.

- You must add the `part 'your_file.g.dart';` statement at the top of the file.
- Add the `@inheritedModelState` annotation to the state fields you want to manage.

**lib/main_model.dart**
```dart
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'main_model.g.dart';

// 1. Define the FlutterInheritedModel annotation
@FlutterInheritedModel(
  name: 'MainInheritedModel',
  event: MainModelEvent,
)
// 2. Add the generated Mixin with the 'with' keyword.
class MainModel with $MainModel {
  // 3. Create a private constructor and a factory constructor that connects to the generated class.
  MainModel._();
  factory MainModel() = _$MainModel;

  // 4. Specify the state to manage with the @inheritedModelState annotation.
  @inheritedModelState
  late int count;

  // Lifecycle callback for model initialization
  @override
  void onInitState() {
    super.onInitState();
    count = 0;
  }

  // Lifecycle callback for model disposal
  @override
  void onDispose() {
    super.onDispose();
  }

  // Method to change the model state
  void onIncrement() {
    count++;
  }

  // Deliver UI Event
  void onShowSnapBar(String message) {
    emitEvent(MainModelSnackBarEvent(message));
  }
}

// Define events for model-UI interaction
sealed class MainModelEvent {}

class MainModelSnackBarEvent implements MainModelEvent {
  final String message;

  MainModelSnackBarEvent(this.message);
}
```

### 2. Run Code Generation

Run the following command in the root directory of your project to generate the code.

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Provide the Model in the Widget Tree

Wrap the widget tree where you want to share the state with the generated `MainInheritedModel` widget.

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainInheritedModel(
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
```

### 4. Use the State in the UI

In child widgets, you can easily access the model and state using the generated static methods.

- `MainInheritedModel.model(context)`: Accesses the model instance (for method calls, etc.).
- `MainInheritedModel.countOf(context)`: Accesses the `count` state. The widget is rebuilt only when this state changes.

```dart
class _MainPage extends StatelessWidget {
  const _MainPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InheritedModel Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            // Depends only on the 'count' state using countOf()
            // A Builder was used to create a context to change only the Text Widget.
            Builder(
              builder: (context) {
                return Text(
                  '${MainInheritedModel.countOf(context)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call the model's method
          MainInheritedModel.model(context).onIncrement();
          MainInheritedModel.model(context).onShowSnapBar('Increment');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## Advanced Usage: Managing Sub-states with @FlutterInheritedState

Sometimes, a model's state can become complex and have multiple responsibilities. Using `@FlutterInheritedState`, you can encapsulate related state and logic into a separate class to keep the model cleaner.

### 1. Define a Sub-state Class

Define a class to manage the sub-state using the `@FlutterInheritedState` annotation.

**lib/user_state.dart**
```dart
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'user_state.g.dart';

// 1. Define the FlutterInheritedState annotation
@FlutterInheritedState(name: 'UserInheritedState')
// 2. Add the generated Mixin with the 'with' keyword.
class UserState with $UserState {
  // 3. Create a private constructor and a factory constructor that connects to the generated class.
  UserState._();
  factory UserState() = _$UserState;

  // 4. Specify the state to manage with the @inheritedModelState annotation.
  @inheritedModelState
  late String name;

  @inheritedModelState
  late int age;

  // Lifecycle callback when UserInheritedState is attached
  @override
  void onAttachState() {
    super.onAttachState();
  }

  // Lifecycle callback when UserInheritedState is detached
  @override
  void onDetachState() {
    super.onDetachState();
  }
}
```

### 2. Include the Sub-state in the Main Model

In the main model, declare `UserState`, which has the `@FlutterInheritedState` annotation, as a field. After building, you can access the state of `UserState` from the UI through the generated code (`_$MyModel.userStateOf(context)`).

**lib/main.dart**
```dart
// ... (existing code)

@FlutterInheritedModel(
  name: 'MainInheritedModel',
  // ...
)
class MainModel with $MainModel {
  // ... (existing code)

  // Include UserState as a sub-state
  final userState = UserState();

  @override
  void onInitState() {
    super.onInitState();
    count = 0;
    // Initialize sub-state
    userState.name = 'Gemini';
    userState.age = 1;
  }

  @override
  void onDispose() {
    // The state must be disposed of on exit.
    userState.dispose();
    super.onDispose();
  }
}

// ... (rest of the code)
```
### 3. Provide the Model in the Widget Tree
Wrap the widget tree where you want to share the state with the generated `UserInheritedState` widget.

```dart
class _MainPage extends StatelessWidget {
  const _MainPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InheritedModel Example')),
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
            /// Add `UserInheritedState`. 
            /// You can use `UserInheritedState` in `UserProfileWidget`.
            UserInheritedState(
                state: MainInheritedModel
                    .model(context)
                    .userState,
                child: UserProfileWidget())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MainInheritedModel.model(context).onIncrement();
          MainInheritedModel.model(context).onShowSnapBar('Increment');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```
### 4. Use the Sub-state in the UI

Now, in the UI, you can access the `name` and `age` states of `UserState` through `UserInheritedState` and be rebuilt according to changes.

```dart
class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Rebuild only when the name of UserState changes
    final userName = UserInheritedState.nameOf(context);
    // Rebuild only when the age of UserState changes
    final userAge = UserInheritedState.ageOf(context);

    return Column(
      children: [
        Text('User Name: $userName'),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.exposure_plus_1)),
            Text('User Age: $userAge'),
            IconButton(onPressed: () {}, icon: Icon(Icons.exposure_minus_1)),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            // Call the sub-state's method through the model
            final model = UserInheritedState.model(context);
            model.name = 'Bard';
            model.age = 2;
          },
          child: const Text('Update User'),
        ),
      ],
    );
  }
}
```

## Async Processing and Loading State Management: `useAsyncWorker`

With the `useAsyncWorker: true` option, you can use an `asyncWorker` that is managed in sync with the model's lifecycle. 
This allows you to execute tasks that require a Future, such as network requests. You can also check the task's status through `InheritedModel.asyncWorkingOf(context)`.

To improve the user experience, you can display the progress of an asynchronous task in the UI by checking the status with `InheritedModel.asyncWorkingOf(context)`.

### 1. Enable `useAsyncWorker`

Add `useAsyncWorker: true` to the `@FlutterInheritedModel` annotation.

**lib/main_model.dart**
```dart
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'main_model.g.dart';

@FlutterInheritedModel(
  name: 'MainInheritedModel',
  useAsyncWorker: true, // Enable async worker
)
class MainModel with $MainModel {
  MainModel._();
  factory MainModel() = _$MainModel;
  
  @inheritedModelState
  late String data;

  @override
  void onInitState() {
    super.onInitState();
    data = 'Press the button to fetch data.';
  }

  // Register a default handler for errors that occur when running an async function with asyncWorker.
  @override
  void Function(Object e, StackTrace stackTrace)? get asyncWorkerDefaultError => (e, stackTrace) {
    emitEvent(MainModelSnackBarEvent(e.toString()));
  };
  
  // Asynchronous data loading method
  void onFetchData() {
    asyncWorker(() async {
      await Future.delayed(const Duration(seconds: 3));
      data = 'Data fetched successfully!';
    });
  }

  // Asynchronous data error method
  // If an error handler is not provided, the asyncWorkerDefaultError function is called to handle the error.
  void onFetchDataError() {
    asyncWorker(() async {
      await Future.delayed(const Duration(seconds: 3));
      throw Exception('asyncWorker error');
    });
  }
}
```

### 2. Configure the UI based on Loading State

In the UI, subscribe to the `MainInheritedModel.asyncWorkingOf(context)` state. When it's `true`, display a loading indicator that covers the entire screen. Using a `Stack` widget makes it easy to add an overlay on top of the existing UI.

**lib/main_page.dart**
```dart
class _MainPage extends StatelessWidget {
  const _MainPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Async Worker Loading Example')),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Builder(builder: (context) {
                  return Text(
                    MainInheritedModel.dataOf(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }),
                ElevatedButton(onPressed: () {
                  MainInheritedModel.model(context).onFetchDataError();
                }, child: Text('Fetch error')),
              ],
            ),
          ),
          /// Use a Builder to show the loading UI only when asyncWorking.
          Builder(
            builder: (context) {
              final asyncWorking = MainInheritedModel.asyncWorkingOf(context);
              if (!asyncWorking) {
                return const SizedBox();
              }
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                alignment: AlignmentDirectional.center,
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MainInheritedModel.model(context).onFetchData();
        },
        tooltip: 'Fetch Data',
        child: const Icon(Icons.cloud_download),
      ),
    );
  }
}
```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.