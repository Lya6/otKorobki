import 'package:flutter/material.dart';
import 'package:template_application/models/categories.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/category/category_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class CategoryListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<CategoryViewModel> listCategories = List<CategoryViewModel>();

  void categories() async {
    List<Categories> listCategories = await WebService().fetchCategories();
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listCategories = listCategories
        .map((category) => CategoryViewModel(categories: category))
        .toList();

    this.listCategories.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
