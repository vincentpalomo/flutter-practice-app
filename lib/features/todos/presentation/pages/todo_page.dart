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
        title: const Text('Todo App', style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text('Drawer Header',
                  style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
              //   update the state of the app
              },
            ),
            ListTile(
              title: const Text('Contact'),
              onTap: () {
              //   update the state of the app
              },
            )
          ],
        ),
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
        // Center the title
        titlePadding: const EdgeInsets.all(16),
        title: const Center(
          child: Text(
            'Add Todo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Center the content
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              textAlign: TextAlign.center, // Center the input text
              decoration: const InputDecoration(
                hintText: 'Enter todo title',
                hintStyle: TextStyle(color: Colors.white70),
                // Center the hint text
                alignLabelWithHint: true,
                // Optional: customize the text field appearance
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
              style: const TextStyle(color: Colors.white), // Input text color
            ),
          ],
        ),

        backgroundColor: Colors.deepOrangeAccent,

        // Center the action buttons
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
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
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
  //   final textController = TextEditingController();
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       titlePadding: const EdgeInsets.all(16),
  //       title: const Text('Add Todo', style: TextStyle(
  //         color: Colors.white
  //       ),),
  //
  //       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  //       content: TextField(
  //         controller: textController,
  //         decoration: const InputDecoration(
  //           hintText: 'Enter todo title',
  //         ),
  //       ),
  //       backgroundColor: Colors.deepOrangeAccent,
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             if (textController.text.isNotEmpty) {
  //               ref
  //                   .read(todoControllerProvider.notifier)
  //                   .addTodo(textController.text);
  //               Navigator.pop(context);
  //             }
  //           },
  //           child: const Text('Add'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}