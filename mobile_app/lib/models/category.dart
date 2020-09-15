import 'package:flutter/foundation.dart' show required;

const categoriesAssets = {
  'Furniture': 'assets/categories/furniture.jpg',
  'Clothes': 'assets/categories/clothes.jpg',
  'Electronics': 'assets/categories/electronics.jpg',
  'Books': 'assets/categories/books.jpg',
  'Pets accessories': 'assets/categories/pets_accessories.jpg',
  'tools': 'assets/categories/tools.jpg',
};


class Category {
  final int id;
  final String name;
  final String asset;

  const Category({@required this.id, @required this.name, this.asset});


  static String getAsset(String name) {
    return categoriesAssets[name];
  }
}