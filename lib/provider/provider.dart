import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_verify/model/todo.dart';

// todoを管理する用
class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(Todo todo) {
    // stateに値の参照が格納されている
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = state.where((elem) => elem.id != todoId).toList();
  }
}

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void incrementCounter() {
    state++;
  }
}

// 定義したProvider(グローバル)
// StateProviderは「enumや数値」などシンプルなステートを管理するのに適している
final titleProvider = StateProvider((ref) => "タイトル");

// todo
final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
    (ref) => TodoListNotifier());

// カウンター
final counterProvider =
    StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());
