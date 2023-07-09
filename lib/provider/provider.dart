import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_verify/model/todo.dart';

// todoを管理する用
class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier()
      : super([
          Todo(id: '0', title: 'メモ0'),
          Todo(id: '1', title: 'メモ1'),
          Todo(id: '2', title: 'メモ2'),
        ]);

  void addTodo(Todo todo) {
    // stateに値が格納されている
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = state.where((elem) => elem.id != todoId).toList();
  }
}

// 定義したProvider(グローバル)
// StateProviderは「enumや数値」などシンプルなステートを管理するのに適している
final titleProvider = StateProvider((ref) => "タイトル");
final counterProvider = StateProvider((ref) => 0);

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
    (ref) => TodoListNotifier());
