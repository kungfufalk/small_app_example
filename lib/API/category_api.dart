import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Constants/constants.dart';
import 'api_structs.dart';
import 'package:http/http.dart' as http;

final categoryAPIRepository = Provider<CategoryApi>((ref) => CategoryRestApi());

abstract interface class CategoryApi {
  Future<Category> addCategory(Category category);

  Future<List<Category>> getCategories();
}

class CategoryRestApi implements CategoryApi {
  @override
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

  @override
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
