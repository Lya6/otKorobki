import 'package:template_application/models/goods.dart';

class SearchViewModel {
  Goods _newGoods;

  SearchViewModel({Goods goods}) : _newGoods = goods;

  String get goodsId {
    return _newGoods.goodsId;
  }

  String get goodsName {
    return _newGoods.goodsName;
  }

  String get storeId {
    return _newGoods.storeId;
  }

  String get buyCount {
    return _newGoods.buyCount;
  }

  String get measureUnitTxt {
    return _newGoods.measureUnitTxt;
  }

  String get packageSize {
    return _newGoods.packageSize;
  }

  String get goodsPrice {
    return _newGoods.goodsPrice;
  }

  String get goodsAdjustedName {
    return _newGoods.goodsAdjustedName;
  }

  String get inMyBasketreId {
    return _newGoods.inMyBasket;
  }

  String get goodsDescription {
    return _newGoods.goodsDescription;
  }

  String get storeName {
    return _newGoods.storeName;
  }

  String get fullGoodsName {
    return _newGoods.fullGoodsName;
  }

  String get brandName {
    return _newGoods.brandName;
  }

  String get manufacturerName {
    return _newGoods.manufacturerName;
  }

  String get unitWeight {
    return _newGoods.unitWeight;
  }
}
