import 'package:flutter/material.dart';
import 'package:template_application/models/goods.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/new_goods/new_goods_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class NewGoodsListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<NewGoodsViewModel> listNewGoods = List<NewGoodsViewModel>();

  void newGoods(String parentId, String userId) async {
    List<Goods> listNewGoods =
        await WebService().fetchNewGoods(parentId, userId);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listNewGoods = listNewGoods
        .map((newGoods) => NewGoodsViewModel(newGoods: newGoods))
        .toList();

    this.listNewGoods.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
