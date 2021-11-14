import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditTodoDialog extends StatelessWidget {
  final String _initialText;
  final _textFieldController = TextEditingController();
  final void Function(String content) _editTodoItem;

  EditTodoDialog(this._initialText, this._editTodoItem, {Key? key}) {
    _textFieldController.text = _initialText;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit description'),
      content: TextField(
          controller: _textFieldController,
          decoration:
              const InputDecoration(hintText: 'Enter description here')),
      actions: <Widget>[
        // Save button
        TextButton(
          child: const Text('SAVE'),
          onPressed: () {
            Navigator.of(context).pop();
            _editTodoItem(_textFieldController.text);
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
