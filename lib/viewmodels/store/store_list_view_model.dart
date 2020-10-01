import 'package:flutter/material.dart';
import 'package:template_application/models/stores.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/store/store_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class StoreListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<StoreViewModel> listStores = List<StoreViewModel>();

  void stores(int userId, String parentId) async {
    List<Stores> listStores = await WebService().fetchStores(userId, parentId);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listStores =
        listStores.map((stores) => StoreViewModel(stores: stores)).toList();

    this.listStores.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
