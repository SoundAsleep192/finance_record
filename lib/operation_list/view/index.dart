import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import 'package:finance_record/operation_list/logic/models/operation.dart';
import 'package:finance_record/operation_list/logic/persistence/operation_repository.dart';

import 'scaffold.dart';

class OperationList extends StatefulWidget {
  const OperationList({Key? key}) : super(key: key);

  @override
  _OperationListState createState() => _OperationListState();
}

class _OperationListState extends State<OperationList> {
  final _repo = OperationRepository();
  final Map<String, Operation> _items = {};

  @override
  Widget build(BuildContext context) {
    return OperationListScaffold(_items, _addItem, _deleteItem, _editItem);
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

  void _addItem(int amount, String categoryId, String comment) {
    var id = const Uuid().v4();
    var newItem = Operation(id, DateTime.now(), amount, categoryId, comment);

    setState(() {
      _items[id] = newItem;
      _repo.saveItems(_items);
    });
  }

  void _deleteItem(String id) {
    setState(() {
      _items.remove(id);
      _repo.saveItems(_items);
    });
  }

  void _editItem(Operation changedItem) {
    setState(() {
      _items[changedItem.id] = changedItem;

      _repo.saveItems(_items);
    });
  }
}
