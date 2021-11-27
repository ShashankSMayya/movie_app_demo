import 'dart:convert';

import 'package:http/http.dart';

import 'api_constants.dart';


class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.get(_getPath(path, params),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);

    } else {
      throw Exception(response.reasonPhrase);
    }
  }


  Uri _getPath(String path, Map<dynamic, dynamic>? params) {
    var paramString = '?api_key=${ApiConstants.apiKey}';
    // if (params != null) {
    //   paramString = "?";
    // }
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramString += '&$key=$value';
      });
    }

    return Uri.parse('${ApiConstants.baseUrl}$path$paramString');
  }
}
