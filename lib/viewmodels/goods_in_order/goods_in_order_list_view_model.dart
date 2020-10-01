import 'package:flutter/material.dart';
import 'package:template_application/models/goods_in_order.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/goods_in_order/goods_in_order_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class GoodsInOrderListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.searching;
  List<GoodsInOrderViewModel> listGoodsInOrder = List<GoodsInOrderViewModel>();

  void goodsInOrder(int userId, String storeId, String parentId) async {
    List<GoodsInOrder> listGoodsInOrder =
        await WebService().fetchGoodsInOrder(userId, storeId, parentId);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listGoodsInOrder = listGoodsInOrder
        .map(
            (goodsInOrder) => GoodsInOrderViewModel(goodsInOrder: goodsInOrder))
        .toList();

    this.listGoodsInOrder.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
