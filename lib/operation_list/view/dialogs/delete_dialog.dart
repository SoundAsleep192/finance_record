import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final void Function() _deleteItem;

  const DeleteDialog(this._deleteItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete operation?'),
      actions: <Widget>[
        // Approve button
        TextButton(
          child: const Text('YES'),
          onPressed: () {
            Navigator.of(context).pop();
            _deleteItem();
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
