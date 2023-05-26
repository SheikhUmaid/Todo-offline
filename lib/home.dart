import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/dialogbox.dart';
import 'package:todo/todo_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  List todoList = [];

  final _dbBox = Hive.box('dbBox');

  @override
  void initState() {
    super.initState();
    if (_dbBox.get('todos') == null) {
      _dbBox.put('todos', todoList);
    } else {
      todoList = _dbBox.get('todos');
    }
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
      _dbBox.put('todos', todoList);
    });
  }

  void addNewTodo() {
    setState(() {
      todoList.add([_controller.text.toString(), false]);
      _controller.clear();
      _dbBox.put('todos', todoList);
    });
    Navigator.of(context).pop();
  }

  void createNewTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: addNewTodo,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  deleteTodo(int index) {
    setState(() {
      todoList.removeAt(index);
      _dbBox.put('todos', todoList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
        title: const Text(
          'To Do',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: todoList[index][0],
            taskCompleted: todoList[index][1],
            onChanged: (val) => checkBoxChanged(val, index),
            deleteTodo: (context) => deleteTodo(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTodo(),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
