const categories = <int, String>{
  0: 'furniture',
  1: 'clothes',
  2: 'electronics',
  3: 'books',
  4: 'pets accessories',
  5: 'tools',
};

class Post {
  final int id;

  final int categoryId;
  final String subCategory;
  final String description;
  final String country;
  final String city;
  final List<String> urlImages;

  final String phoneNumber;

  String get category => categories[categoryId];

  Post(
      {this.id,
      this.categoryId,
      this.subCategory,
      this.description,
      this.country,
      this.city,
      this.urlImages,
      this.phoneNumber});
}
