import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'todo_item.dart';

void main() {
  runApp(const Todo());
}

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // save data
  Map<String, TodoItem> _todos = {};
  // text field
  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView(children: _getItems()),
      // add items to the to-do list
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  @override
  void initState() {
    _getStoredTodos();
    super.initState();
  }

  void _getStoredTodos() async {
    var prefs = await SharedPreferences.getInstance();
    var storedTodos = Map<String, TodoItem>.from(
        json.decode(prefs.getString('todos') ?? '{}'));
    setState(() {
      _todos = storedTodos;
    });
  }

  void _addTodoItem(String content) async {
    var todoId = const Uuid().v4();
    var newTodoItem =
        TodoItem(todoId, content, DateTime.now().toIso8601String());

    var prefs = await SharedPreferences.getInstance();

    setState(() {
      _todos[todoId] = newTodoItem;
      prefs.setString('todos', json.encode(_todos));
    });
    _textFieldController.clear();
  }

  void _removeTodoItem(String id) async {}

  // this Generate list of item widgets
  Widget _buildTodoItemWidget(TodoItem todoItem) {
    return ListTile(
      leading: const Icon(Icons.summarize_outlined),
      title: Text(todoItem.content),
      subtitle: Text('Created at: ' + todoItem.createdAt),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle),
        onPressed: () => _removeTodoItem(todoItem.id),
      ),
    );
  }

  // display a dialog for the user to enter items
  Future<AlertDialog?> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              // add button
              TextButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              // Cancel button
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  // iterates through our todo list title
  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (var todoItem in _todos.values) {
      _todoWidgets.add(_buildTodoItemWidget(todoItem));
    }
    return _todoWidgets;
  }
}
