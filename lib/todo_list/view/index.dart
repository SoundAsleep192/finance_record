import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import 'package:finance_record/todo_list/logic/models/todo_item_model.dart';
import 'package:finance_record/todo_list/logic/persistence/todo_items_repository.dart';

import 'scaffold.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _repo = TodoItemsRepository();
  final Map<String, TodoItemModel> _items = {};

  @override
  Widget build(BuildContext context) {
    return TodoListScaffold(_items, _addItem, _deleteItem, _editItem);
  }

  @override
  void initState() {
    _getStoredItems();
    super.initState();
  }

  void _getStoredItems() async {
    var itemsFromRepo = await _repo.getItems();

    setState(() {
      for (var item in itemsFromRepo.entries) {
        _items[item.key] = item.value;
      }
    });
  }

  void _addItem(String content) {
    var todoId = const Uuid().v4();
    var newItem =
        TodoItemModel(todoId, content, DateTime.now().toIso8601String());
    setState(() {
      _items[todoId] = newItem;
      _repo.saveItems(_items);
    });
  }

  void _deleteItem(String id) async {
    setState(() {
      _items.remove(id);
      _repo.saveItems(_items);
    });
  }

  void _editItem(String id, String content) async {
    setState(() {
      _items[id]?.content = content;
      _repo.saveItems(_items);
    });
  }
}
