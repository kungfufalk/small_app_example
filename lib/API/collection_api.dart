import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:small_app_example/API/api_structs.dart';
import 'package:small_app_example/Constants/constants.dart';

class ItemApi {
  bool responseSuccessful(http.Response response) {
    if (response.statusCode == 200) {
      print('all good');
      return true;
    } else {
      print("Something went terribly wrong");
      return false;
    }
  }

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

  Future<bool> deleteItem(ID id) async {
    var uriString = '$itemUri/$id';
    var uri = Uri.parse(uriString);
    var response = await http.delete(uri);
    if (responseSuccessful(response)) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

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

class CategoryApi {
  Future<Category> addCategory(Category category) async {
    var uriString = categoryUri;
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
    var uriString = categoryUri;
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

class CollectionApi {
  Future<Collection> createCollection(Collection collection) async {
    var uriString = collectionUri;
    var uri = Uri.parse(uriString);
    var jsonBody = jsonEncode(collection.toJson());
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonBody);
    if (responseSuccessful(response)) {
      return Future.value(Collection.fromJson(jsonDecode(response.body)));
    } else {
      return Future.error(throw Exception('createCollection failed'));
    }
  }

  Future<CollectionItem> addItemToCollection(
      CollectionItem collectionItem) async {
    var collectionId = collectionItem.collectionId;
    var itemId = collectionItem.itemId;
    var uriString = '$collectionUri/$collectionId/$itemId';
    var uri = Uri.parse(uriString);
    var response = await http.post(uri);
    if (responseSuccessful(response)) {
      return Future.value(CollectionItem.fromJson(jsonDecode(response.body)));
    } else {
      return Future.error(throw Exception('addItemToCollection failed'));
    }
  }

  Future<List<Item>> getItemsInCollection(Collection collection) async {
    var collectionId = collection.id;
    var uriString = '$collectionUri/$collectionId./items';
    var uri = Uri.parse(uriString);
    var response = await http.get(uri);
    if (responseSuccessful(response)) {
      Iterable itemsJson = jsonDecode(response.body);
      List<Item> items = List.from(itemsJson.map((e) => Item.fromJson(e)));
      return Future.value(items);
    } else {
      return Future.error(throw Exception('addItemToCollection failed'));
    }
  }

  Future<CollectionItem> removeItemFromCollection(
      CollectionItem collectionItem) async {
    var collectionId = collectionItem.collectionId;
    var itemId = collectionItem.itemId;
    var uriString = '$collectionUri/$collectionId/$itemId';
    var uri = Uri.parse(uriString);
    var response = await http.delete(uri);
    if (responseSuccessful(response)) {
      return Future.value(CollectionItem.fromJson(jsonDecode(response.body)));
    } else {
      return Future.error(throw Exception('addItemToCollection failed'));
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
