import 'package:http/http.dart' as http;
import 'package:small_app_example/api_structs.dart';
import 'package:small_app_example/constants.dart';

class CollectionApi {

  Future<http.Response> addItem(Item item){
    var uriString = baseUri + '/item';
    var uri = Uri.http(uriString);
    return http.post(uri, body: item.toJson());
  }
  Future<http.Response> addItem(Item item){
    var uriString = baseUri + '/item';
    var uri = Uri.http(uriString);
    return http.post(uri, body: item.toJson());
  }
}

void main(List<String> arguments) async {

}