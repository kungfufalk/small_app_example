import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../Constants/constants.dart';
import 'api_structs.dart';
import 'package:http/http.dart' as http;

final itemAPIRepository = Provider<ItemApi>((ref) => ItemRestApi());

abstract interface class ItemApi {
  Future<Item> addItem(Item item);

  Future<bool> deleteItem(Item item);

  Future<Item> getItemById(ID id);

  Future<List<Item>> getItemByName(String searchString);

  Future<List<Item>> getItems();
}

class ItemDummyApi implements ItemApi {
  final Item testItem = const Item(null, 'test', 'description', 1, 1);
  static const List<Item> testItems = [
    Item(1, 'test', 'description', 1, null),
    Item(2, 'test2', 'description2', 2, null),
    Item(3, 'test3', 'description3', 3, null)
  ];

  @override
  Future<Item> addItem(Item item) async {
    if (item.name == 'success') {
      return Future.delayed(const Duration(seconds: 3), () => item);
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<bool> deleteItem(Item item) async {
    if (item.name == 'success') {
      return Future.delayed(const Duration(seconds: 3), () => true);
    } else {
      return Future.error('error');
    }
  }

  @override
  Future<Item> getItemById(ID id) async {
    if (testItem.id == id) {
      return Future.delayed(const Duration(seconds: 3), () => testItem);
    } else {
      return Future.error('error');
    }
  }

  @override
  Future<List<Item>> getItemByName(String searchString) async {
    if (searchString == testItems[0].name) {
      return Future.delayed(const Duration(seconds: 3), () => testItems);
    } else {
      return Future.error('error');
    }
  }

  @override
  Future<List<Item>> getItems() async {
    return Future.delayed(const Duration(seconds: 3), () => testItems);
  }
}

class ItemRestApi implements ItemApi {
  bool responseSuccessful(http.Response response) {
    if (response.statusCode == 200) {
      print('all good');
      return true;
    } else {
      print("Something went terribly wrong");
      return false;
    }
  }

  @override
  Future<Item> addItem(Item item) async {
    var uriString = itemUri;
    var uri = Uri.parse(uriString);
    var categoryJson = jsonEncode(item.toJson());
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: categoryJson);
    if (responseSuccessful(response)) {
      return Future.value(Item.fromJson(jsonDecode(response.body)));
    } else {
      return Future.error('error');
    }
  }

  @override
  Future<bool> deleteItem(Item item) async {
    var id = item.id;
    var uriString = '$itemUri/$id';
    var uri = Uri.parse(uriString);
    var response = await http.delete(uri);
    if (responseSuccessful(response)) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<Item> getItemById(ID id) async {
    var uriString = '$itemUri/$id';
    var uri = Uri.parse(uriString);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return Future.value(Item.fromJson(jsonDecode(response.body)));
    } else {
      return Future.error('error');
    }
  }

  @override
  Future<List<Item>> getItemByName(String searchString) async {
    var uriString = '$itemUri/search/$searchString';
    var uri = Uri.parse(uriString);
    var response = await http.get(uri);
    if (responseSuccessful(response)) {
      Iterable jsonBody = jsonDecode(response.body);
      List<Item> items = List<Item>.from(jsonBody.map((e) => Item.fromJson(e)));
      return Future.value(items);
    } else {
      return Future.error('getItemByName failed');
    }
  }

  @override
  Future<List<Item>> getItems() async {
    var uriString = itemUri;
    var uri = Uri.parse(uriString);
    var response = await http.get(uri);
    if (responseSuccessful(response)) {
      Iterable jsonBody = jsonDecode(response.body);
      List<Item> items = List<Item>.from(jsonBody.map((e) => Item.fromJson(e)));
      return Future.value(items);
    } else {
      return Future.error('getItemByName failed');
    }
  }
}
