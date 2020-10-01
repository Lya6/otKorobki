class SubCategories {
  final String id;
  final String name;

  SubCategories({
    this.id,
    this.name,
  });

  factory SubCategories.fromJson(Map<String, dynamic> json) {
    return SubCategories(
      id: json['id'],
      name: json['name'],
    );
  }
}
