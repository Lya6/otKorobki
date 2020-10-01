import 'package:template_application/models/address.dart';

class AddressViewModel {
  Address _address;

  AddressViewModel({Address address}) : _address = address;

  int get id {
    return _address.id;
  }

  String get address {
    return _address.address;
  }
}
