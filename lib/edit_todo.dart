import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqflite/provider/todos.dart';

class EditTodo extends StatelessWidget {
  EditTodo(
      {super.key,
      required this.id,
      required this.title,
      required this.description});
  int id;
  String title;
  String description;
  @override
  Widget build(BuildContext context) {
    Todos todos = Provider.of<Todos>(context);
    todos.titleController.text = title;
    todos.descController.text = description;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: todos.titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: todos.descController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (todos.titleController.text.isNotEmpty &&
                      todos.descController.text.isNotEmpty) {
                    todos.editData(id);
                  }

                  Navigator.pop(context);
                },
                child: const Text("Edit"))
          ],
        ),
      ),
    );
  }
}
