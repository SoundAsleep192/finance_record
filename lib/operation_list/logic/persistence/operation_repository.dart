import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:finance_record/operation_list/logic/models/operation.dart';

class OperationRepository {
  final _key = 'operations';

  OperationRepository();

  Future<Map<String, Operation>> getItems() async {
    var prefs = await SharedPreferences.getInstance();

    Map<String, Operation> parsedItems = {};

    Map<String, dynamic> storedItems =
        json.decode(prefs.getString(_key) ?? '{}');

    for (var storedItem in storedItems.entries) {
      var decodedItem = Operation.fromJson(storedItem.value);
      parsedItems[storedItem.key] = decodedItem;
    }

    return parsedItems;
  }

  void saveItems(Map<String, Operation> items) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(_key, json.encode(items));
  }
}
