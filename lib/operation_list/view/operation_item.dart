import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:finance_record/operation_list/logic/models/operation.dart';

import 'dialogs/delete_dialog.dart';
import 'dialogs/edit_dialog.dart';

class OperationItem extends StatelessWidget {
  final Operation _model;
  final void Function(String id) _deleteItem;
  final void Function(Operation changedItem) _editItem;

  const OperationItem(this._model, this._deleteItem, this._editItem, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_model.amount.toString()),
        subtitle: Text(_model.comment),
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
          return DeleteDialog(() => _deleteItem(itemId));
        });
  }

  Future<AlertDialog?> _displayEditDialog(BuildContext context, String itemId) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return EditDialog(_model, _editItem);
        });
  }
}
