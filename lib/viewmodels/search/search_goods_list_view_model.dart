import 'package:flutter/material.dart';
import 'package:template_application/models/goods.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/goods/goods_view_model.dart';
import 'package:template_application/viewmodels/search/search_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class SearchGoodsListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<SearchViewModel> listGoods = List<SearchViewModel>();

  void goods(String symbol, String parentId, int userId) async {
    List<Goods> listGoods =
        await WebService().fetchSeachGoods(symbol, parentId, userId);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listGoods =
        listGoods.map((goods) => SearchViewModel(goods: goods)).toList();

    this.listGoods.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
