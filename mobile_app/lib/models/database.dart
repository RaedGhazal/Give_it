import 'dart:convert';

import 'package:flutter/foundation.dart' show required;

import 'package:http/http.dart' as http;

import 'category.dart';
import 'post.dart';

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

Future<Map<String, dynamic>> getAllCategories() async {
  const url = "https://raedghazal.com/giveit_project/categories.php";
  final response = await http.post(url, body: {"function": "get_all"});
  print(json.decode(response.body));

  return json.decode(response.body);
}

Future<List<Category>> getUsedCategories(
    {String country = 'jordan', String city = ''}) async {
  const url = "https://raedghazal.com/giveit_project/categories.php";
  final response = await http.post(url, body: {
    "function": "get_used",
    'by_city': city == '' ? '0' : '1',
    'country': country,
    'city': city
  });
  print(json.decode(response.body));
  var jsonCategories = json.decode(response.body);
  if (jsonCategories is List) return List<Category>();

  List<Category> categories = <Category>[];
  for (var id in jsonCategories.keys) {
    categories.add(Category(
      id: int.parse(id),
      name: jsonCategories[id],
      asset: Category.getAsset(jsonCategories[id]),
    ));
  }

  return categories;
}
//TODO:DELETE AFTER TEST

Future<List<Post>> getPosts(
    {String country, String city, int categoryId}) async {
  const url = 'https://raedghazal.com/giveit_project/posts.php';
  final response = await http.post(url, body: {
    'function': 'get_all',
    'country': country,
    'city': city,
    'category_id': categoryId?.toString() ?? ''
  });
  print('Input : country = $country , city = $city , categoryId = $categoryId');

  List jsonPosts = json.decode(response.body);
  print(jsonPosts);
  List<Post> posts = List<Post>();
  for (Map p in jsonPosts) {
    var post = Post(
        id: int.parse(p['post_id']),
        categoryId: int.parse(p['category_id']),
        categoryName: p['category_name'],
        subCategory: p['sub_category'],
        description: p['description'],
        country: p['country'],
        city: p['city'],
        imagesUrl: p['image_url'],
        phoneNumber: p['phone_number']);

    posts.add(post);
  }

  print('posts: $posts');

  return posts;
}
