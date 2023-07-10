import 'dart:convert';
import '../Constants/constants.dart';
import 'api_structs.dart';
import 'package:http/http.dart' as http;

abstract interface class ItemApi {
  Future<Item> addItem(Item item);

  Future<bool> deleteItem(Item item);

  Future<Item> getItemById(ID id);

  Future<List<Item>> getItemByName(String searchString);

  Future<List<Item>> getItems();
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
      return Future.error(throw Exception('addItem failed'));
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
      return Future.error(throw Exception('addCategory failed'));
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
      return Future.error(throw Exception('getItemByName failed'));
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
      return Future.error(throw Exception('getItemByName failed'));
    }
  }
}
