import 'package:flutter/material.dart';

import 'package:finance_record/todo_list/list_item.dart';
import 'package:finance_record/todo_list/models/todo_item_model.dart';

class TodoListScaffold extends StatelessWidget {
  final Map<String, TodoItemModel> _items;
  final Function _displayAddDialog;
  final Function _removeTodoItem;

  const TodoListScaffold(
      this._items, this._displayAddDialog, this._removeTodoItem,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView(
          children: _items.values
              .map((item) => TodoListItem(item, _removeTodoItem))
              .toList()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayAddDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }
}
