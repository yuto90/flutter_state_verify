import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_verify/provider/count_provider.dart';
import 'package:flutter_state_verify/provider/title_provider.dart';

// Widgetを部分更新する場合はConsumerを使わずStatelessWidgetを使う
class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(ref.watch(titleNotifierProvider))),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ref.watch(countNotifierProvider).toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(
                onPressed: () => ref
                    .read(titleNotifierProvider.notifier)
                    .changeTitle("タイトルが変わった"),
                child: const Text("タイトルを変更"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(countNotifierProvider.notifier).incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
