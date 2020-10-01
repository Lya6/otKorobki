class Categories {
  final String id;
  final String name;
  final String imagePreview;

  Categories({this.id, this.name, this.imagePreview});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
        id: json['id'],
        name: json['name'],
        imagePreview: json['image_preview']);
  }
}
