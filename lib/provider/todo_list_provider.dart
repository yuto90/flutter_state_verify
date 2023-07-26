import 'package:flutter_state_verify/model/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'todo_list_provider.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  @override
  List<Todo> build() {
    return [];
  }

  // void switchCompleted(int switchTodoId) {
  //   state.map((todo) {
  //     if (todo.id == switchTodoId) {
  //       Todo newTodo = todo.copyWith(completed: !todo.completed);
  //       return newTodo;
  //     }
  //     return todo ;
  //   });
  // }
}
