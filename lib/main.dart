import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_verify/model/todo.dart';
import 'package:flutter_state_verify/provider/provider.dart';

void main() {
  // 状態管理をスコープを設定するためにWidgetツリーの最上位にProviderScopeを配置
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  // ConsumerWidgetを継承する時refを引数で受け取る
  // refにアクセスする事で定義したProviderにアクセスが可能
  Widget build(BuildContext context, WidgetRef ref) {
    // watchで定義したProviderの値を監視
    final int counter = ref.watch(counterProvider);

    final List<Todo> todoList = ref.watch(todoListProvider);

    void _incrementCounter() {
      // notifierでデータを更新
      final notifier = ref.read(counterProvider.notifier);
      notifier.state++;
    }

    void add() {
      // notifierでデータを更新
      final notifier = ref.read(counterProvider.notifier);
      notifier.state++;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // watchで変更を監視
        title: Text(ref.watch(titleProvider)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                counter.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              todoList.isEmpty
                  ? const Text("Todoが無いよ")
                  : ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (final todo in todoList)
                          ListTile(
                            title: Text(todo.title),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                ref
                                    .read(todoListProvider.notifier)
                                    .removeTodo(todo.id);
                              },
                            ),
                          ),
                      ],
                    ),
              ElevatedButton(
                onPressed: () => add(),
                child: const Text("Todoを追加"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
