import 'package:flutter/foundation.dart' show required;

const categories = [
  'empty',
  'Furniture',
  'Clothes',
  'Electronics',
  'Books',
  'Pets accessories',
  'tools',
];

const categoriesAssets = {
  'Furniture': 'assets/categories/furniture.jpg',
  'Clothes': 'assets/categories/clothes.jpg',
  'Electronics': 'assets/categories/electronics.jpg',
  'Books': 'assets/categories/books.jpg',
  'Pets accessories': 'assets/categories/pets_accessories.jpg',
  'Tools': 'assets/categories/tools.jpg',
};

class Category {
  final int id;
  final String name;
  final String asset;

  Category({@required this.id, @required this.name, this.asset});

  static String getAsset(String name) {
    return categoriesAssets[name];
  }
}
