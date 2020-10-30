import 'dart:convert';

import 'package:gank_flutter/models/cocktail.dart';
import 'package:http/http.dart' as http;

class CocktailProvider {
  static const baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1/';
  static http.Client httpClient = http.Client();

  Future<Map<String, dynamic>> getData() async {
    final http.Response response = await httpClient.get(
      baseUrl + 'filter.php?a=Non_Alcoholic',
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
    );
    Map<String, dynamic> responseData = setupResponse(response);
    if (responseData['status_code'] == 200) {
      responseData['data'] = (responseData['drinks'] as List)
          .map((n) => Cocktail.fromMap(n))
          .toList();
    }
    return responseData;
  }

  Map<String, dynamic> setupResponse(http.Response response) {
    Map<String, dynamic> responseData = {};
    if (response.statusCode != 200) {
      responseData['status'] = false;
      if (response.statusCode == 404) {
        responseData['data'] = 'Server not found.';
      } else if (response.statusCode == 401) {
        responseData['data'] = 'Unauthenticated.';
      } else {
        responseData['data'] = 'Something when wrong, please try again.';
      }
    } else {
      responseData = json.decode(response.body);
      responseData['status'] = true;
      responseData['status_code'] = response.statusCode;
    }
    return responseData;
  }
}
