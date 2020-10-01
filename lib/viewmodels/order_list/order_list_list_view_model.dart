import 'package:flutter/material.dart';
import 'package:template_application/models/order_list.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/order_list/order_list_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class OrderListListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<OrderListViewModel> listOrders = List<OrderListViewModel>();

  void orders(int userId) async {
    List<OrderList> listOrders = await WebService().fetchOrders(userId);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listOrders =
        listOrders.map((orders) => OrderListViewModel(orders: orders)).toList();

    this.listOrders.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
