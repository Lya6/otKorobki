import 'package:flutter/material.dart';
import 'package:template_application/models/regions.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/region/region_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class RegionListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<RegionViewModel> listRegions = List<RegionViewModel>();

  void regions() async {
    List<Regions> listRegions = await WebService().fetchRegions();
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listRegions = listRegions
        .map((regions) => RegionViewModel(regions: regions))
        .toList();

    this.listRegions.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
