import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:finance_record/todo_list/logic/models/todo_item_model.dart';

import 'dialogs/delete_dialog.dart';
import 'dialogs/edit_dialog.dart';

class TodoItem extends StatelessWidget {
  final TodoItemModel _model;
  final void Function(String id) _deleteItem;
  final void Function(String id, String content) _editItem;

  const TodoItem(this._model, this._deleteItem, this._editItem, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.summarize_outlined),
        title: Text(_model.content),
        subtitle: Text('Created at: ' + _model.createdAt),
        trailing: Wrap(children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _displayEditDialog(context, _model.id),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _displayDeleteDialog(context, _model.id),
          )
        ]));
  }

  Future<AlertDialog?> _displayDeleteDialog(
      BuildContext context, String itemId) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return DeleteTodoDialog(() => _deleteItem(itemId));
        });
  }

  Future<AlertDialog?> _displayEditDialog(BuildContext context, String itemId) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return EditTodoDialog(
              _model.content, (text) => _editItem(itemId, text));
        });
  }
}
