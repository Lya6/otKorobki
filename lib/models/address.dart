class Address {
  final int id;
  final String address;

  Address({this.id, this.address});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(id: json['id'], address: json['address']);
  }
}
