import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:small_app_example/api_structs.dart';
import 'package:small_app_example/constants.dart';

class CollectionApi {
  Future<Item> addItem(Item item) async {
    var uriString = '$baseUri/item';
    var uri = Uri.parse(uriString);
    var categoryJson = jsonEncode(item.toJson());
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: categoryJson);
    if (response.statusCode == 200) {
      print('all good');
      return Future.value(Item.fromJson(jsonDecode(response.body)));
    } else {
      print("Something went terribly wrong");
      return Future.error(throw Exception('addItem failed'));
    }
  }

  Future<bool> deleteItem(ID id) async {
    var uriString = '$baseUri/item/$id';
    var uri = Uri.parse(uriString);
    var response = await http.delete(uri);
    if (responseSuccessful(response)) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<Item> getItemById(ID id) async {
    var uriString = '$baseUri/item/$id';
    var uri = Uri.parse(uriString);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print('all good');
      return Future.value(Item.fromJson(jsonDecode(response.body)));
    } else {
      print("Something went terribly wrong");
      return Future.error(throw Exception('addCategory failed'));
    }
  }

  Future<List<Item>> getItemByName(String searchString) async {
    var uriString = '$baseUri/item/search/$searchString';
    var uri = Uri.parse(uriString);
    var response = await http.get(uri);
    if (responseSuccessful(response)) {
      Iterable jsonBody = jsonDecode(response.body);
      List<Item> items = List<Item>.from(jsonBody.map((e) => Item.fromJson(e)));
      return Future.value(items);
    } else {
      return Future.error(throw Exception('getItemByName failed'));
    }
  }

  Future<List<Item>> getItems() async {
    var uriString = '$baseUri/item';
    var uri = Uri.parse(uriString);
    var response = await http.get(uri);
    if (responseSuccessful(response)) {
      Iterable jsonBody = jsonDecode(response.body);
      List<Item> items = List<Item>.from(jsonBody.map((e) => Item.fromJson(e)));
      return Future.value(items);
    } else {
      return Future.error(throw Exception('getItemByName failed'));
    }
  }

  Future<Category> addCategory(Category category) async {
    var uriString = '$baseUri/category';
    var uri = Uri.parse(uriString);
    var categoryJson = jsonEncode(category.toJson());
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: categoryJson);
    if (responseSuccessful(response)) {
      return Future.value(Category.fromJson(jsonDecode(response.body)));
    } else {
      return Future.error(throw Exception('addCategory failed'));
    }
  }

  Future<List<Category>> getCategories() async {
    var uriString = '$baseUri/category';
    var uri = Uri.parse(uriString);
    var response = await http.get(uri);
    if (responseSuccessful(response)) {
      Iterable jsonBody = jsonDecode(response.body);
      List<Category> categories =
          List<Category>.from(jsonBody.map((e) => Category.fromJson(e)));
      return Future(() => categories);
    } else {
      return Future.error(throw Exception('getCategories failed'));
    }
  }

  bool responseSuccessful(http.Response response) {
    if (response.statusCode == 200) {
      print('all good');
      return true;
    } else {
      print("Something went terribly wrong");
      return false;
    }
  }
}
