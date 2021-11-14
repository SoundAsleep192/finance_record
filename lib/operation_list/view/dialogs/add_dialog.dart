import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final void Function(int amount, String categoryId, String comment) _addItem;

  AddDialog(this._addItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adding operation'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(hintText: 'Enter amount'),
            keyboardType: TextInputType.number,
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
        TextButton(
          child: const Text('ADD'),
          onPressed: () {
            Navigator.of(context).pop();

            var amount = int.parse(_amountController.text);
            var category = _categoryController.text;
            var comment = _commentController.text;

            _addItem(amount, category, comment);

            _amountController.clear();
            _categoryController.clear();
            _commentController.clear();
          },
        ),
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
