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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Text(ref.watch(titleProvider));
        }),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                return Text(
                  ref.watch(counterProvider).toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }),
              Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                final List<Todo> todoList = ref.watch(todoListProvider);
                return ListView(
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
                );
              }),
              Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                return ElevatedButton(
                  onPressed: () => ref.read(todoListProvider.notifier).addTodo(
                        Todo(id: "10", title: "メモ10"),
                      ),
                  child: const Text("Todoを追加"),
                );
              })
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return FloatingActionButton(
          onPressed: () =>
              ref.read(counterProvider.notifier).incrementCounter(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
