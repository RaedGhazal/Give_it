import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

//TODO: Add implementation.
Future<void> addPost({
  @required String phoneNumber,
  @required String userToken,
  @required List<List<String>> images,
  @required int categoryId,
  @required String subCategory,
  @required String country,
  @required String city,
  @required String description,
}) async {
  const url = "https://raedghazal.com/giveit_project/posts.php";

  final response = await http.post(url, body: {
    'function': 'add',
    'phone_number': phoneNumber,
    'user_token': userToken,
    'images': jsonEncode(images),
    'category_id': '$categoryId',
    'sub_category': '$subCategory',
    'country': country,
    'city': city,
    'description': description,
  });

  print(response.body);
}

Future<Map<String , dynamic>> getAllCategories() async {
  const url = "https://raedghazal.com/giveit_project/categories.php";
  final response = await http.post(url, body: {"function": "get_all"});
  print(json.decode(response.body));

  return json.decode(response.body);
}
