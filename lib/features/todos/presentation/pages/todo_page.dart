import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/todo_controller.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App', style: TextStyle( color: Colors.white)),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                color: Colors.white
              ),
            ),
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) => ref
                  .read(todoControllerProvider.notifier)
                  .toggleTodo(todo.id),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref
                  .read(todoControllerProvider.notifier)
                  .deleteTodo(todo.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.deepOrangeAccent,
    );
  }

  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Enter todo title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                ref
                    .read(todoControllerProvider.notifier)
                    .addTodo(textController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}