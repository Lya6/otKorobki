import 'package:template_application/models/stores.dart';

class StoreViewModel {
  Stores _stores;

  StoreViewModel({Stores stores}) : _stores = stores;

  String get storeId {
    return _stores.storeId;
  }

  String get storeName {
    return _stores.storeName;
  }

  String get storeAddressPickup {
    return _stores.storeAddressPickup;
  }
}
