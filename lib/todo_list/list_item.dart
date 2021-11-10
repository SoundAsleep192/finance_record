import 'package:finance_record/todo_list/models/todo_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoListItem extends StatelessWidget {
  final TodoItemModel _todoItemModel;
  final Function _removeTodoItem;
  const TodoListItem(this._todoItemModel, this._removeTodoItem, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.summarize_outlined),
      title: Text(_todoItemModel.content),
      subtitle: Text('Created at: ' + _todoItemModel.createdAt),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle),
        onPressed: () => _removeTodoItem(_todoItemModel.id),
      ),
    );
  }
}
