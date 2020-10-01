import 'package:flutter/material.dart';
import 'package:template_application/models/address.dart';
import 'package:template_application/services/web_service.dart';
import 'package:template_application/viewmodels/address/address_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class AddressListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<AddressViewModel> listAddress = List<AddressViewModel>();

  void address(int userId) async {
    List<Address> listAddress = await WebService().fetchAddress(userId);
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.listAddress = listAddress
        .map((address) => AddressViewModel(address: address))
        .toList();

    this.listAddress.isEmpty
        ? this.loadingStatus = LoadingStatus.empty
        : this.loadingStatus = LoadingStatus.completed;

    notifyListeners();
  }
}
