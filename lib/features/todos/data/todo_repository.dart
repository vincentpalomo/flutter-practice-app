import '../domain/todo.dart';

class TodoRepository {
  final List<Todo> _todos = [];

  List<Todo> getTodos() => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void toggleTodo(String id) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);

    if (todoIndex != -1) {
      final todo = _todos[todoIndex];
      _todos[todoIndex] = todo.copyWith(isCompleted: !todo.isCompleted);
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }
}