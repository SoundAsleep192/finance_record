import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:finance_record/operation_list/logic/models/operation.dart';

class EditDialog extends StatelessWidget {
  final Operation _model;
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _categoryController = TextEditingController();
  final _commentController = TextEditingController();
  final void Function(Operation changedItem) _editItem;

  EditDialog(this._model, this._editItem, {Key? key}) : super(key: key) {
    _amountController.text = _model.amount.toString();
    _dateController.text = _model.date.toString();
    _categoryController.text = _model.categoryId;
    _commentController.text = _model.comment;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit operation'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(hintText: 'Enter amount'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _dateController,
            decoration: const InputDecoration(hintText: 'Enter date'),
            keyboardType: TextInputType.datetime,
          ),
          TextField(
            controller: _categoryController,
            decoration: const InputDecoration(hintText: 'Enter category'),
            keyboardType: TextInputType.text,
          ),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(hintText: 'Enter comment'),
            keyboardType: TextInputType.text,
          ),
        ],
      ),
      actions: <Widget>[
        // Save button
        TextButton(
          child: const Text('SAVE'),
          onPressed: () {
            Navigator.of(context).pop();

            var id = _model.id;
            var date = DateTime.parse(_dateController.text);
            var amount = int.parse(_amountController.text);
            var categoryId = _categoryController.text;
            var comment = _commentController.text;

            var changedItem = Operation(id, date, amount, categoryId, comment);

            _editItem(changedItem);

            _amountController.clear();
            _dateController.clear();
            _categoryController.clear();
            _commentController.clear();
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
  }
}
