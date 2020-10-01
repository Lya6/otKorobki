import 'package:template_application/models/order_list.dart';

class OrderListViewModel {
  OrderList _orders;

  OrderListViewModel({OrderList orders}) : _orders = orders;

  String get numberOrder {
    return _orders.numberOrder;
  }

  String get dateCreate {
    return _orders.dateCreate;
  }

  String get deliveryType {
    return _orders.deliveryType;
  }

  String get orderSum {
    return _orders.orderSum;
  }
}
