import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqflite/add_todo.dart';
import 'package:todo_sqflite/edit_todo.dart';
import 'package:todo_sqflite/provider/todos.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    Todos todos = Provider.of<Todos>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => Todos(),
                  child: const AddTodo(),
                ),
              )).then((value) => setState(
                () {},
              ));
        },
        child: const Icon(Icons.add_task),
      ),
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: FutureBuilder(
        future: todos.getTodo(),
        builder: (context, snapshot) {
          if (todos.itemTodo.isEmpty) {
            return const Center(
              child: Text('Data Kosong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: todos.itemTodo.length,
              itemBuilder: (context, index) {
                final todo = todos.itemTodo[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => Todos(),
                            child: EditTodo(
                                id: todo.id,
                                title: todo.title,
                                description: todo.description),
                          ),
                        )).then((value) => setState(
                          () {},
                        ));
                  },
                  child: ListTile(
                    subtitle: Text(todo.description),
                    title: Text(todo.title),
                    trailing: IconButton(
                        onPressed: () {
                          todos.deleteTodo(todo.id);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
