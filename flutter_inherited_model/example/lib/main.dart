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
  event: MainModelEvent,
  useAsyncWorker: true,
)
class MainModel with $MainModel {
  MainModel._();

  factory MainModel() = _$MainModel;

  @inheritedModelState
  late int count;

  final userState = UserState();

  @inheritedModelState
  late String data;

  @override
  void onInitState() {
    super.onInitState();
    count = 0;

    userState.name = 'Gemini';
    userState.age = 1;

    data = '버튼을 눌러 데이터를 가져오세요.';
  }

  @override
  void onDispose() {
    userState.dispose();
    super.onDispose();
  }

  void onIncrement() {
    count++;
  }

  void onShowSnapBar(String message) {
    emitEvent(MainModelSnackBarEvent(message));
  }

  @override
  void Function(Object e, StackTrace stackTrace)? get asyncWorkerDefaultError =>
      (e, stackTrace) {
        emitEvent(MainModelSnackBarEvent(e.toString()));
      };

  void onFetchData() {
    asyncWorker(() async {
      await Future.delayed(const Duration(seconds: 3));
      data = '데이터 로딩 성공!';
    });
  }

  void onFetchDataError() {
    asyncWorker(() async {
      await Future.delayed(const Duration(seconds: 3));
      throw Exception('asyncWorker error');
    });
  }
}

sealed class MainModelEvent {}

class MainModelSnackBarEvent implements MainModelEvent {
  final String message;

  MainModelSnackBarEvent(this.message);
}

@FlutterInheritedState(name: 'UserInheritedState')
class UserState with $UserState {
  UserState._();

  factory UserState() = _$UserState;

  @inheritedModelState
  late String name;

  @inheritedModelState
  late int age;

  @override
  void onAttachState() {
    super.onAttachState();
    debugPrint('UserState onAttachState');
  }

  @override
  void onDetachState() {
    debugPrint('UserState onDetachState');
    super.onDetachState();
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
// class _MainPage extends StatelessWidget {
//   const _MainPage();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('InheritedModel Example')),
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const Text('You have pushed the button this many times:'),
//                 Builder(
//                   builder: (context) {
//                     return Text(
//                       '${MainInheritedModel.countOf(context)}',
//                       style: Theme.of(context).textTheme.headlineMedium,
//                     );
//                   },
//                 ),
//                 Card(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Builder(
//                         builder: (context) {
//                           return Text(
//                             MainInheritedModel.dataOf(context),
//                             style: Theme.of(context).textTheme.titleMedium,
//                           );
//                         },
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         spacing: 8,
//                         children: [
//                           ElevatedButton(onPressed: () {
//                             MainInheritedModel.model(context).onFetchData();
//                           }, child: Text('fetch')),
//                           ElevatedButton(onPressed: () {
//                             MainInheritedModel.model(context).onFetchDataError();
//                           }, child: Text('error')),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 UserInheritedState(
//                   state: MainInheritedModel.model(context).userState,
//                   child: UserProfileWidget(),
//                 ),
//               ],
//             ),
//           ),
//           Builder(
//             builder: (context) {
//               final asyncWorking = MainInheritedModel.asyncWorkingOf(context);
//               if (!asyncWorking) {
//                 return const SizedBox();
//               }
//               return Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: Colors.transparent,
//                 alignment: AlignmentDirectional.center,
//                 child: CircularProgressIndicator(),
//               );
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           MainInheritedModel.model(context).onIncrement();
//           MainInheritedModel.model(context).onShowSnapBar('Increment');
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

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
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                UserInheritedState.model(context).age--;
              },
              icon: Icon(Icons.exposure_minus_1),
            ),
            Text('User Age: $userAge'),
            IconButton(
              onPressed: () {
                UserInheritedState.model(context).age++;
              },
              icon: Icon(Icons.exposure_plus_1),
            ),
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
