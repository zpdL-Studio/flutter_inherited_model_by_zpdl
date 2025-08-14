# flutter_inherited_model

[![pub package](https://img.shields.io/pub/v/flutter_inherited_model.svg)](https://pub.dev/packages/flutter_inherited_model)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[ENGLISH](https://github.com/zpdL-Studio/flutter_inherited_model_by_zpdl/blob/main/flutter_inherited_model/README.md) | 한국어

Flutter의 `InheritedModel`을 코드 생성(code generation) 기반으로 손쉽게 사용할 수 있도록 도와주는 상태 관리 패키지입니다.

복잡한 설정 없이 간단한 어노테이션(@) 사용만으로 `InheritedModel`의 강력한 기능을 활용할 수 있으며, 상태 변화에 따라 정말 필요한 위젯만 리빌드하여 앱 성능을 최적화합니다.

이 패키지는 `flutter_inherited_model_builder`와 함께 사용해야 합니다.

## 주요 기능

- **간결한 구문**: `@FlutterInheritedModel` 어노테이션 하나로 `InheritedModel` 위젯을 자동 생성합니다.
- **성능 최적화**: 상태(state) 필드를 자동으로 감지하여, 특정 상태에 의존하는 위젯만 리빌드합니다.
- **세분화된 상태 관리**: `@FlutterInheritedState`를 사용하여 모델 내부에 또 다른 하위 상태(State)를 정의하고 관리할 수 있습니다. 이를 통해 복잡한 상태 로직을 더욱 체계적으로 구성하고 분리할 수 있습니다.
- **생명주기(Lifecycle) 관리**: `onInitState`, `onDispose`, `onDidChangeAppLifecycleState` 등 위젯의 생명주기 이벤트를 모델 클래스 내에서 직접 관리할 수 있습니다.
- **이벤트 처리**: `Event` 시스템을 통해 모델과 UI 간의 상호작용(예: SnackBar 표시, 페이지 이동)을 손쉽게 처리할 수 있습니다.
- **비동기 작업 지원**: `useAsyncWorker` 옵션으로 모델 내에서 안전하게 비동기 작업을 수행할 수 있습니다.

## 설치하기

`pubspec.yaml` 파일에 아래와 같이 의존성을 추가해주세요.

```yaml
dependencies:
  flutter_inherited_model: ^0.9.5 # pub.dev에서 최신 버전을 확인해주세요.

dev_dependencies:
  flutter_inherited_model_builder: ^0.9.5 # 최신 버전을 확인해주세요.
  build_runner: ^2.5.4 # build_runner 버전은 호환성에 맞게 조정될 수 있습니다.
```

## 기본 사용법

### 1. 모델 클래스 생성

상태를 관리할 클래스를 만들고 `@FlutterInheritedModel` 어노테이션을 붙여줍니다.

- `part 'your_file.g.dart';` 구문을 파일 상단에 추가해야 합니다.
- 관리할 상태 필드에는 `@inheritedModelState` 어노테이션을 추가합니다.

**lib/main_model.dart**
```dart
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'main_model.g.dart';

// 1. FlutterInheritedModel annotation 정의
@FlutterInheritedModel(
  name: 'MainInheritedModel',
  event: MainModelEvent,
)
// 2. 생성될 Mixin을 with 키워드로 추가합니다.
class MainModel with $MainModel {
  // 3. private 생성자와 생성될 클래스를 연결하는 factory 생성자를 만듭니다.
  MainModel._();
  factory MainModel() = _$MainModel;

  // 4. @inheritedModelState 어노테이션으로 관리할 상태를 지정합니다.
  @inheritedModelState
  late int count;

  // 모델 초기화를 위한 생명주기 콜백
  @override
  void onInitState() {
    super.onInitState();
    count = 0;
  }

  // 모델이 종료될때 종료 생명주기 콜백
  @override
  void onDispose() {
    super.onDispose();
  }

  // 모델 상태를 변경하는 메소드
  void onIncrement() {
    count++;
  }

  // UI Event 전달
  void onShowSnapBar(String message) {
    emitEvent(MainModelSnackBarEvent(message));
  }
}

// 모델과 UI의 상호작용을 위한 이벤트 정의
sealed class MainModelEvent {}

class MainModelSnackBarEvent implements MainModelEvent {
  final String message;

  MainModelSnackBarEvent(this.message);
}
```

### 2. 코드 생성 실행

프로젝트의 루트 디렉토리에서 아래 명령어를 실행하여 코드를 생성합니다.

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. 위젯 트리에서 모델 제공하기

생성된 `MainInheritedModel` 위젯으로 상태를 공유할 위젯 트리를 감싸줍니다.

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

### 4. UI에서 상태 사용하기

하위 위젯에서는 생성된 static 메소드를 사용하여 모델과 상태에 쉽게 접근할 수 있습니다.

- `MainInheritedModel.model(context)`: 모델 인스턴스에 접근합니다. (메소드 호출 등)
- `MainInheritedModel.countOf(context)`: `count` 상태에 접근합니다. 이 상태가 변경될 때만 위젯이 리빌드됩니다.

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
            // countOf()를 사용하여 'count' 상태에만 의존
            // Text Widget 만 변경을 위해 Builder로 context를 생성하였다.
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
          // 모델의 메소드 호출
          MainInheritedModel.model(context).increment();
          MainInheritedModel.model(context).onShowSnapBar('Increment');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## 고급 사용법: @FlutterInheritedState로 하위 상태 관리하기

때로는 모델의 상태가 복잡해져서 여러 책임을 가지게 될 수 있습니다. `@FlutterInheritedState`를 사용하면 관련된 상태와 로직을 별도의 클래스로 캡슐화하여 모델을 더 깔끔하게 유지할 수 있습니다.

### 1. 하위 상태 클래스 정의

`@FlutterInheritedState` 어노테이션을 사용하여 하위 상태를 관리할 클래스를 정의합니다.

**lib/user_state.dart**
```dart
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'user_state.g.dart';

// 1. FlutterInheritedState annotation 정의
@FlutterInheritedState(name: 'UserInheritedState')
// 2. 생성될 Mixin을 with 키워드로 추가합니다.
class UserState with $UserState {
  // 3. private 생성자와 생성될 클래스를 연결하는 factory 생성자를 만듭니다.
  UserState._();
  factory UserState() = _$UserState;

  // 4. @inheritedModelState 어노테이션으로 관리할 상태를 지정합니다.
  @inheritedModelState
  late String name;

  @inheritedModelState
  late int age;

  // UserInheritedState에 attach 될때에 생명 주기 콜백
  @override
  void onAttachState() {
    super.onAttachState();
  }

  // UserInheritedState에 detach 될때에 생명 주기 콜백
  @override
  void onDetachState() {
    super.onDetachState();
  }
}
```

### 2. 메인 모델에 하위 상태 포함

메인 모델에서 `@FlutterInheritedState`가 붙은 `UserState`를 필드로 선언합니다. 빌드 후 생성되는 코드(`_$MyModel.userStateOf(context)`)를 통해 UI에서 `UserState`의 상태에 접근할 수 있게 됩니다.

**lib/main.dart**
```dart
// ... (기존 코드)

@FlutterInheritedModel(
  name: 'MainInheritedModel',
  // ...
)
class MainModel with $MainModel {
  // ... (기존 코드)

  // UserState를 하위 상태로 포함
  final userState = UserState();

  @override
  void onInitState() {
    super.onInitState();
    count = 0;
    // 하위 상태 초기화
    userState.name = 'Gemini';
    userState.age = 1;
  }

  @override
  void onDispose() {
    // 종료시 state를 폐기 시켜주어야 한다.
    userState.dispose();
    super.onDispose();
  }
}

// ... (나머지 코드)
```
### 3. 위젯 트리에서 모델 제공하기
생성된 `UserInheritedState` 위젯으로 상태를 공유할 위젯 트리를 감싸줍니다.

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
            /// `UserInheritedState` 추가. 
            /// `UserProfileWidget` 에서 `UserInheritedState`를 사용할 수 있습니다.
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
### 4. UI에서 하위 상태 사용하기

이제 UI에서는 `UserInheritedState`을 통해 `UserState`의 `name`과 `age` 상태에도 접근하고 변화에 따라 리빌드될 수 있습니다.

```dart
class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // UserState의 name이 변경될 때만 리빌드
    final userName = UserInheritedState.nameOf(context);
    // UserState의 age가 변경될 때만 리빌드
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
            // 모델을 통해 하위 상태의 메소드 호출
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

## 비동기 처리와 로딩 상태 관리: `useAsyncWorker`

`useAsyncWorker: true` 옵션을 사용하면 모델의 생명주기에 맞춰 관리되는 `asyncWorker`를 사용할 수 있습니다. 
이를 통해 네트워크 요청등 Future가 필요한 작업을 실행할 수 있으며, `InheritedModel.asyncWorkingOf(context)`를 통해서 작업 상태를 추가 확인할 수 있습니다.

비동기 작업의 진행 상태를 UI에 표시하기 위해 `InheritedModel.asyncWorkingOf(context)`를 통해서 작업 상태를 추가하여 사용자 경험을 향상할 수 있습니다.

### 1. `useAsyncWorker` 활성화 및 로딩 상태 추가

`@FlutterInheritedModel` 어노테이션에 `useAsyncWorker: true`를 추가하고, 로딩 상태를 관리할 `isLoading` 필드를 `@inheritedModelState`와 함께 선언합니다.

**lib/main_model.dart**
```dart
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'main_model.g.dart';

@FlutterInheritedModel(
  name: 'MainInheritedModel',
  useAsyncWorker: true, // 비동기 워커 활성화
)
class MainModel with $MainModel {
  MainModel._();
  factory MainModel() = _$MainModel;
  
  @inheritedModelState
  late String data;

  @override
  void onInitState() {
    super.onInitState();
    data = '버튼을 눌러 데이터를 가져오세요.';
  }

  // asyncWorker로 비동기 함수 실행시에 Error 발생시 Default 처리 함수 등록
  @override
  void Function(Object e, StackTrace stackTrace)? get asyncWorkerDefaultError => (e, stackTrace) {
    emitEvent(MainModelSnackBarEvent(e.toString()));
  };
  
  // 비동기 데이터 로딩 메소드
  void onFetchData() {
    asyncWorker(() async {
      await Future.delayed(const Duration(seconds: 3));
      data = '데이터 로딩 성공!';
    });
  }

  // 비동기 데이터 에러 메소드
  // error를 등록하지 않았을 경우에 asyncWorkerDefaultError 함수를 호출해서 에러를 처리한다.
  void onFetchDataError() {
    asyncWorker(() async {
      await Future.delayed(const Duration(seconds: 3));
      throw Exception('asyncWorker error');
    });
  }
}
```

### 2. UI에서 로딩 상태에 따라 화면 구성

UI에서는 `MainInheritedModel.asyncWorkingOf(context)` 상태를 구독하여 `true`일 때 화면 전체를 덮는 로딩 인디케이터를 표시합니다. `Stack` 위젯을 사용하면 기존 UI 위에 손쉽게 오버레이를 추가할 수 있습니다.

**lib/main_page.dart**
```dart
class _MainPage extends StatelessWidget {
  const _MainPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Async Worker 로딩 예제')),
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
          /// Builder를 사용하여 asyncWorking 에만 로딩 UI 호출
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

## 라이선스

이 프로젝트는 MIT 라이선스를 따릅니다. 자세한 내용은 `LICENSE` 파일을 참고하세요.
