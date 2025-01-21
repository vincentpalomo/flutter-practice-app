import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/todo.dart';

final todoControllerProvider = StateNotifierProvider<TodoController, List<Todo>>((ref) {
  return TodoController();
});

class TodoController extends StateNotifier<List<Todo>> {
  TodoController() : super([]); // Initialize with empty list

  void addTodo(String title) {
    final todo = Todo(
      id: const Uuid().v4(),
      title: title,
    );
    // Create new list with the new todo
    state = [...state, todo];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}