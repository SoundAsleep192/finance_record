import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoDialog extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();
  final void Function(String) _addTodoItem;

  AddTodoDialog(this._addTodoItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a task to your list'),
      content: TextField(
        controller: _textFieldController,
        decoration: const InputDecoration(hintText: 'Enter task here'),
      ),
      actions: <Widget>[
        // Add button
        TextButton(
          child: const Text('ADD'),
          onPressed: () {
            Navigator.of(context).pop();
            _addTodoItem(_textFieldController.text);
            _textFieldController.clear();
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
