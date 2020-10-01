class GoodsOrder {
  final String id;
  final String goodsId;
  final String goodsName;
  final String goodsAdjustedName;
  final String countInOrder;
  final String priceInOrder;

  GoodsOrder({
    this.id,
    this.goodsId,
    this.goodsName,
    this.goodsAdjustedName,
    this.countInOrder,
    this.priceInOrder,
  });

  factory GoodsOrder.fromJson(Map<String, dynamic> json) {
    return GoodsOrder(
        id: json['id'],
        goodsId: json['goods_id'],
        goodsName: json['goods_name'],
        goodsAdjustedName: json['goods_adjusted_name'],
        countInOrder: json['count_in_order'],
        priceInOrder: json['price_in_order']);
  }
}
