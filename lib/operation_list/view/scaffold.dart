import 'package:flutter/material.dart';

import 'package:finance_record/operation_list/logic/models/operation.dart';

import 'dialogs/add_dialog.dart';
import 'operation_item.dart';

class OperationListScaffold extends StatelessWidget {
  final Map<String, Operation> _itemModels;
  final void Function(int amount, String categoryId, String comment) _addItem;
  final void Function(String id) _deleteItem;
  final void Function(Operation changedItem) _editItem;

  const OperationListScaffold(
      this._itemModels, this._addItem, this._deleteItem, this._editItem,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Operation list')),
      body: ListView(
          children: _itemModels.values
              .map((itemModel) =>
                  OperationItem(itemModel, _deleteItem, _editItem))
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
          return AddDialog(_addItem);
        });
  }
}
