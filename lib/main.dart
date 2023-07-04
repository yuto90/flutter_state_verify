import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  runApp(const MyApp());
}

// 定義したProvider(グローバル)
final titleProvider = StateProvider((ref) => "タイトル");
final counterProvider = StateProvider((ref) => 0);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
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

    void _incrementCounter() {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              counter.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
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
