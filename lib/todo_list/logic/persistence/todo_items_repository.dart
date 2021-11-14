import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:finance_record/todo_list/logic/models/todo_item_model.dart';

class TodoItemsRepository {
  final _key = 'todos';

  TodoItemsRepository();

  Future<Map<String, TodoItemModel>> getItems() async {
    var prefs = await SharedPreferences.getInstance();

    Map<String, TodoItemModel> parsedItems = {};

    Map<String, dynamic> storedItems =
        json.decode(prefs.getString(_key) ?? '{}');

    for (var storedItem in storedItems.entries) {
      var decodedItem = TodoItemModel.fromJson(storedItem.value);
      parsedItems[storedItem.key] = decodedItem;
    }

    return parsedItems;
  }

  void saveItems(Map<String, TodoItemModel> items) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(_key, json.encode(items));
  }
}
