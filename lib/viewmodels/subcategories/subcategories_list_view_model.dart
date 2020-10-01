import 'package:flutter/material.dart';
import 'package:template_application/models/subcategories.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/subcategories/subcategories_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class SubcategoriesListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<SubcategoriesViewModel> listSubcategories =
      List<SubcategoriesViewModel>();

  void subcategories(String idCategory, String parentId, int userId) async {
    List<SubCategories> listSubcategories =
        await WebService().fetchSubcategories(idCategory, parentId, userId);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listSubcategories = listSubcategories
        .map((subCategories) =>
            SubcategoriesViewModel(subCategories: subCategories))
        .toList();

    this.listSubcategories.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
