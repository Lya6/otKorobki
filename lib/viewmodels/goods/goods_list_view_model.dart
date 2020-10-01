import 'package:flutter/material.dart';
import 'package:template_application/models/goods.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/goods/goods_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class GoodsListViewModel extends ChangeNotifier {
  var loadingStatus = LoadingStatus.searching;
  List<GoodsViewModel> listGoods = List<GoodsViewModel>();

  void goods(String idStore, String parentId, int userId) async {
    List<Goods> listGoods =
        await WebService().fetchGoods(idStore, parentId, userId);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listGoods =
        listGoods.map((goods) => GoodsViewModel(goods: goods)).toList();

    this.listGoods.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
