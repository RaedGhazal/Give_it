class Post {
  final int id;

  final int categoryId;
  final String categoryName;
  final String subCategory;
  final String description;
  final String country;
  final String city;
  final List<String> imagesUrl;

  final String phoneNumber;

  Post(
      {this.id,
      this.categoryId,
      this.categoryName,
      this.subCategory,
      this.description,
      this.country,
      this.city,
      this.imagesUrl,
      this.phoneNumber});
}
