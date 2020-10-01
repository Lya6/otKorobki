class OrderList {
  final String numberOrder;
  final String dateCreate;
  final String deliveryType;
  final String orderSum;

  OrderList(
      {this.numberOrder, this.dateCreate, this.deliveryType, this.orderSum});

  factory OrderList.fromJson(Map<String, dynamic> json) {
    return OrderList(
        numberOrder: json['number_order'],
        dateCreate: json['date_create'],
        deliveryType: json['delivery_type'],
        orderSum: json['order_sum']);
  }
}
