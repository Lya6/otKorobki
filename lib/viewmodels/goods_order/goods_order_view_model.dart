import 'package:template_application/models/goods_order.dart';

class GoodsOrderViewModel {
  GoodsOrder _goodsOrder;

  GoodsOrderViewModel({GoodsOrder goodsOrder}) : _goodsOrder = goodsOrder;

  String get id {
    return _goodsOrder.id;
  }

  String get goodsId {
    return _goodsOrder.goodsId;
  }

  String get goodsName {
    return _goodsOrder.goodsName;
  }

  String get countInOrder {
    return _goodsOrder.countInOrder;
  }

  String get goodsAdjustedName {
    return _goodsOrder.goodsAdjustedName;
  }

  String get priceInOrder {
    return _goodsOrder.priceInOrder;
  }
}
