import 'package:flutter/material.dart';

import 'package:finance_record/todo_list/logic/models/todo_item_model.dart';

import 'dialogs/add_dialog.dart';
import 'todo_item.dart';

class TodoListScaffold extends StatelessWidget {
  final Map<String, TodoItemModel> _itemModels;
  final void Function(String content) _addItem;
  final void Function(String id) _deleteItem;
  final void Function(String id, String content) _editItem;

  const TodoListScaffold(
      this._itemModels, this._addItem, this._deleteItem, this._editItem,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView(
          children: _itemModels.values
              .map((itemModel) => TodoItem(itemModel, _deleteItem, _editItem))
              .toList()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayAddDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  Future<AlertDialog?> _displayAddDialog(BuildContext context) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AddTodoDialog(_addItem);
        });
  }
}
