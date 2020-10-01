class GoodsInOrder {
  final String goodsId;
  final String goodsName;
  final String goodsUnitWeight;
  final String goodsPackageSize;
  final String goodsPrice;
  final String goodsAdjustedName;
  final String countInBaket;
  final String storeId;
  final String buyCount;
  final String totalSumBasket;
  final String goodsMeasureUnitTxt;

  GoodsInOrder(
      {this.goodsId,
      this.goodsName,
      this.goodsUnitWeight,
      this.goodsPackageSize,
      this.goodsPrice,
      this.goodsAdjustedName,
      this.countInBaket,
      this.storeId,
      this.buyCount,
      this.totalSumBasket,
      this.goodsMeasureUnitTxt});

  factory GoodsInOrder.fromJson(Map<String, dynamic> json) {
    return GoodsInOrder(
        goodsId: json['goods_id'],
        goodsName: json['goods_name'],
        goodsUnitWeight: json['goods_unit_weight'],
        goodsPackageSize: json['goods_package_size'],
        goodsPrice: json['goods_price'],
        goodsAdjustedName: json['goods_adjusted_name'],
        countInBaket: json['count_in_baket'],
        storeId: json['store_id'],
        buyCount: json['buy_count'],
        totalSumBasket: json['total_sum_basket'],
        goodsMeasureUnitTxt: json['goods_measure_unit_txt']);
  }
}
