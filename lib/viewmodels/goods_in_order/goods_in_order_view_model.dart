import 'package:template_application/models/goods_in_order.dart';

class GoodsInOrderViewModel {
  GoodsInOrder _goodsInOrder;

  GoodsInOrderViewModel({GoodsInOrder goodsInOrder})
      : _goodsInOrder = goodsInOrder;

  String get goodsId {
    return _goodsInOrder.goodsId;
  }

  String get goodsName {
    return _goodsInOrder.goodsName;
  }

  String get goodsUnitWeight {
    return _goodsInOrder.goodsUnitWeight;
  }

  String get goodsPackageSize {
    return _goodsInOrder.goodsPackageSize;
  }

  String get goodsPrice {
    return _goodsInOrder.goodsPrice;
  }

  String get countInOrder {
    return _goodsInOrder.goodsPrice;
  }

  String get goodsAdjustedName {
    return _goodsInOrder.goodsAdjustedName;
  }

  String get countInBasket {
    return _goodsInOrder.countInBaket;
  }

  String get storeId {
    return _goodsInOrder.storeId;
  }

  String get buyCount {
    return _goodsInOrder.buyCount;
  }

  String get totalSumBasket {
    return _goodsInOrder.totalSumBasket;
  }

  String get goodsMeasureUnitTxt {
    return _goodsInOrder.goodsMeasureUnitTxt;
  }
}
