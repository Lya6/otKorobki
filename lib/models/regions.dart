class Regions {
  final String id;
  final String name;

  Regions({this.id, this.name});

  factory Regions.fromJson(Map<String, dynamic> json) {
    return Regions(id: json['id'], name: json['name']);
  }
}
