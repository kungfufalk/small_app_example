import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:small_app_example/API/api_structs.dart';
import 'package:small_app_example/API/item_api.dart';
import 'package:small_app_example/Constants/constants.dart';
import 'package:small_app_example/Exceptions/collection_api_exceptions.dart';

abstract interface class CollectionApi {
  Future<Collection> createCollection(Collection collection);

  Future<CollectionItem> addItemToCollection(CollectionItem collectionItem);

  Future<List<Item>> getItemsInCollection(Collection collection);

  Future<CollectionItem> removeItemFromCollection(
      CollectionItem collectionItem);
}

class CollectionDummyApi implements CollectionApi {
  static const dummyCollectionName = 'success';

  @override
  Future<CollectionItem> addItemToCollection(CollectionItem collectionItem) {
    if (collectionItem.itemId == 1) {
      return Future.delayed(
        const Duration(seconds: 3),
        () => collectionItem,
      );
    } else {
      throw const AddItemToCollectionError();
    }
  }

  @override
  Future<Collection> createCollection(Collection collection) {
    if (collection.name == dummyCollectionName) {
      return Future.delayed(
        const Duration(seconds: 3),
        () => collection,
      );
    } else {
      throw const CreateCollectionError();
    }
  }

  @override
  Future<List<Item>> getItemsInCollection(Collection collection) {
    if (collection.name == dummyCollectionName) {
      return Future.delayed(
        const Duration(seconds: 3),
        () => ItemDummyApi.testItems,
      );
    } else {
      throw const GetItemsInCollectionError();
    }
  }

  @override
  Future<CollectionItem> removeItemFromCollection(
      CollectionItem collectionItem) {
    if (collectionItem.itemId == 1) {
      return Future.delayed(
        const Duration(seconds: 3),
        () => collectionItem,
      );
    } else {
      throw const RemoveItemFromCollectionError();
    }
  }
}

class CollectionRestApi implements CollectionApi {
  @override
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

  @override
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

  @override
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

  @override
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

final collectionRepository = Provider((ref) => CollectionRestApi());