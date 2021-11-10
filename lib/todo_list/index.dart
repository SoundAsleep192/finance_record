import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:finance_record/todo_list/scaffold.dart';
import 'package:finance_record/todo_list/add_dialog.dart';
import 'package:finance_record/todo_list/models/todo_item_model.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final Map<String, TodoItemModel> _items = {};

  @override
  Widget build(BuildContext context) {
    return TodoListScaffold(_items, _displayAddDialog, _removeItem);
  }

  @override
  void initState() {
    _getStoredItems();
    super.initState();
  }

  void _getStoredItems() async {
    var prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> storedTodos =
        json.decode(prefs.getString('todos') ?? '{}');

    setState(() {
      for (var storedItem in storedTodos.entries) {
        var decodedItem = TodoItemModel.fromJson(storedItem.value);
        _items[storedItem.key] = decodedItem;
      }
    });
  }

  void _addItem(String content) {
    var todoId = const Uuid().v4();
    var newItem =
        TodoItemModel(todoId, content, DateTime.now().toIso8601String());
    setState(() {
      _items[todoId] = newItem;
      _saveItemsToPersistence();
    });
  }

  void _removeItem(String id) async {
    setState(() {
      _items.remove(id);
      _saveItemsToPersistence();
    });
  }

  void _saveItemsToPersistence() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('todos', json.encode(_items));
  }

  Future<AlertDialog?> _displayAddDialog(BuildContext context) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AddTodoDialog(_addItem);
        });
  }
}
