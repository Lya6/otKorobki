import 'package:flutter/material.dart';
import 'package:template_application/models/goods_order.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/goods_order/goods_order_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class GoodsOrderListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<GoodsOrderViewModel> listGoodsOrder = List<GoodsOrderViewModel>();

  void goodsOrder(int userId, String orderId) async {
    List<GoodsOrder> listGoodsOrder =
        await WebService().fetchGoodsOrder(userId, orderId);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listGoodsOrder = listGoodsOrder
        .map((goodsOrder) => GoodsOrderViewModel(goodsOrder: goodsOrder))
        .toList();

    this.listGoodsOrder.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
