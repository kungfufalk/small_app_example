import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:small_app_example/api_structs.dart';
import 'package:small_app_example/constants.dart';

class CollectionApi {
  Future<http.Response> addItem(Item item) {
    var uriString = baseUri + '/item';
    var uri = Uri.parse(uriString);
    return http.post(uri, body: item.toJson());
  }

  Future<Category> addCategory(Category category) async {
    //var uri = Uri.http(baseUri, '/category');
    var uriString = baseUri + '/category';
    var uri = Uri.parse(uriString);
    var categoryJson = jsonEncode(category.toJson());
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: categoryJson);
    if (response.statusCode == 200) {
      print('all good');
      return Future.value(Category.fromJson(jsonDecode(response.body)));
    } else {
      print("Something went terribly wrong");
      return Future.error(throw Exception('addCategory failed'));
    }
  }

  Future<List<Category>> getCategories() async {
    var uriString = baseUri + '/category';
    var uri = Uri.parse(uriString);
    var response = await http.get(uri);
    Iterable jsonBody = jsonDecode(response.body);
    List<Category> categories =
        List<Category>.from(jsonBody.map((e) => Category.fromJson(e)));
    return Future(() => categories);
  }
}

void main(List<String> arguments) async {
  var testCategory = Category(null, 'firstCategory', null);
  var category = await CollectionApi().addCategory(testCategory);
}
