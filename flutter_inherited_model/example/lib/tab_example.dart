import 'package:flutter/material.dart';
import 'package:flutter_inherited_model/flutter_inherited_model.dart';

part 'tab_example.g.dart';

void main() {
  runApp(const MyApp());
}

@FlutterInheritedModel(
  name: 'MainInheritedModel',
  useSingleTickerProvider: true,
  event: MainTapModelEvent,
)
class MainModel with $MainModel {
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  final homeState = HomeState(title: 'HOME');
  @inheritedModelState
  var shoppingState = ShoppingState(title: 'SHOPPING');

  late final tabController = TabController(
    initialIndex: 0,
    length: 3,
    vsync: tickerProvider,
  );

  MainModel._();

  factory MainModel() = _$MainModel;

  @inheritedModelState
  int tabIndex = 0;

  @override
  void onInitState() {
    super.onInitState();
    tabController.addListener(() {
      if (tabIndex != tabController.index) {
        tabIndex = tabIndex;
      }
    });
  }

  @override
  void onDispose() {
    tabController.dispose();
    homeState.dispose();
    super.onDispose();
  }

  void onChangeTab(int index) {
    if (tabIndex == index) {
      return;
    }

    tabController.index = index;
    tabIndex = index;
  }
}

sealed class MainTapModelEvent {}

class MainTapModelSnackBarEvent implements MainTapModelEvent {
  final String message;

  MainTapModelSnackBarEvent(this.message);
}

@FlutterInheritedState(name: 'HomeInheritedState', useAsyncWorker: true)
class HomeState with $HomeState {
  HomeState._();

  factory HomeState({required String title}) = _$HomeState;

  @inheritedModelState
  int count = 0;

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

@FlutterInheritedState(name: 'ShoppingInheritedState')
class ShoppingState with $ShoppingState {
  ShoppingState._();

  factory ShoppingState({required String title}) = _$ShoppingState;

  @inheritedModelState
  int count = 0;

  @override
  void onAttachState() {
    super.onAttachState();
    debugPrint('HomeState onAttachState count: $count');
  }

  @override
  void onDetachState() {
    debugPrint('HomeState onDetachState count: $count');
    super.onDetachState();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Inherited Tab Model Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(
        builder: (context) {
          return MainInheritedModel(
            onEvent: (model, event) async {
              switch (event) {
                case MainTapModelSnackBarEvent():
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(event.message)));
                  return true;
              }
            },
            child: const MainTapPage(),
          );
        },
      ),
    );
  }
}

class MainTapPage extends StatelessWidget {
  const MainTapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = MainInheritedModel.model(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("TAB EXAMPLE"),
      ),
      body: SafeArea(
        child: PageStorage(
          bucket: model.pageStorageBucket,
          child: TabBarView(
            controller: model.tabController,
            children: [
              HomeInheritedState(state: model.homeState, child: _HomeWidget()),
              Builder(
                builder: (context) {
                  return ShoppingInheritedState(
                    state: MainInheritedModel.shoppingStateOf(context),
                    child: _ShoppingWidget(),
                  );
                },
              ),
              Center(
                child: Column(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        MainInheritedModel
                            .model(context)
                            .shoppingState =
                            ShoppingState(title: "SHOPPING(${MainInheritedModel
                                .model(context)
                                .shoppingState
                                .count})");
                        MainInheritedModel
                            .model(context).emitEvent(MainTapModelSnackBarEvent(
                          'Reset shopping state'
                        ));
                      },
                      child: Text('SHOPPING RESET'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          return BottomNavigationBar(
            currentIndex: MainInheritedModel.tabIndexOf(context),
            onTap: model.onChangeTab,
            type: BottomNavigationBarType.fixed,
            backgroundColor: theme.colorScheme.surface,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.colorScheme.onSurfaceVariant,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "홈",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "쇼핑",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: "세팅",
              ),
            ],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
          );
        },
      ),
    );
  }
}

class _HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          '${HomeInheritedState.titleOf(context)} Count : ${HomeInheritedState.countOf(context)}',
        ),
        ElevatedButton(
          onPressed: () {
            HomeInheritedState.model(context).count =
                HomeInheritedState.model(context).count + 1;
          },
          child: Text('ADD'),
        ),
      ],
    );
  }
}

class _ShoppingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          '${ShoppingInheritedState.titleOf(context)} Count : ${ShoppingInheritedState.countOf(context)}',
        ),
        ElevatedButton(
          onPressed: () {
            ShoppingInheritedState.model(context).count =
                ShoppingInheritedState.model(context).count + 1;
          },
          child: Text('ADD'),
        ),
        ElevatedButton(
          onPressed: () {
            MainInheritedModel
                .model(context)
                .shoppingState =
                ShoppingState(title: "SHOPPING(${MainInheritedModel
                    .model(context)
                    .shoppingState
                    .count})");
            MainInheritedModel
                .model(context).emitEvent(MainTapModelSnackBarEvent(
                'Reset shopping state'
            ));
          },
          child: Text('RESET'),
        ),
      ],
    );
  }
}
