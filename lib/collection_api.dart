import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:small_app_example/api_structs.dart';
import 'package:small_app_example/constants.dart';

class CollectionApi {

  Future<http.Response> addItem(Item item){
    var uriString = baseUri + '/item';
    var uri = Uri.http(uriString);
    return http.post(uri, body: item.toJson());
  }
  Future<http.Response> addCategory(Category category) async {
    var uriString = baseUri + '/category';
    var uri = Uri.http(uriString);
    return await http.post(uri, body: category.toJson());
  }
}

void main(List<String> arguments) async {
  var testCategory = Category('firstCategory', id: 1);
  var response = await CollectionApi().addCategory(testCategory);
  if (response.statusCode == 200){
    var returnedCategory = Category.fromJson(jsonDecode(response.body));
  }
  else {
    print("Something went terribly wrong");
  }
}