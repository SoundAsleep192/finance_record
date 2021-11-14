import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteTodoDialog extends StatelessWidget {
  final Function _deleteTodoItem;

  const DeleteTodoDialog(this._deleteTodoItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete task?'),
      actions: <Widget>[
        // Approve button
        TextButton(
          child: const Text('YES'),
          onPressed: () {
            Navigator.of(context).pop();
            _deleteTodoItem();
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
