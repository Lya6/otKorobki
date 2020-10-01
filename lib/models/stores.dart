class Stores {
  final String storeId;
  final String storeName;
  final String storeAddressPickup;

  Stores({this.storeId, this.storeName, this.storeAddressPickup});

  factory Stores.fromJson(Map<String, dynamic> json) {
    return Stores(
        storeId: json['store_id'],
        storeName: json['store_name'],
        storeAddressPickup: json['store_address_pickup']);
  }
}
