class Goods {
  final String goodsId;
  final String goodsName;
  final String storeId;
  final String buyCount;
  final String measureUnitTxt;
  final String packageSize;
  final String goodsPrice;
  final String goodsAdjustedName;
  final String inMyBasket;
  final String goodsDescription;
  final String storeName;
  final String fullGoodsName;
  final String brandName;
  final String manufacturerName;
  final String unitWeight;

  Goods(
      {this.goodsId,
      this.goodsName,
      this.storeId,
      this.buyCount,
      this.measureUnitTxt,
      this.packageSize,
      this.goodsPrice,
      this.goodsAdjustedName,
      this.inMyBasket,
      this.goodsDescription,
      this.storeName,
      this.fullGoodsName,
      this.brandName,
      this.manufacturerName,
      this.unitWeight});

  factory Goods.fromJson(Map<String, dynamic> json) {
    return Goods(
        goodsId: json['goods_id'],
        goodsName: json['goods_name'],
        storeId: json['store_id'],
        buyCount: json['buy_count'],
        measureUnitTxt: json['measure_unit_txt'],
        packageSize: json['package_size'],
        goodsPrice: json['goods_price'],
        goodsAdjustedName: json['goods_adjusted_name'],
        inMyBasket: json['in_my_basket'],
        goodsDescription: json['goods_description'],
        storeName: json['store_name'],
        fullGoodsName: json['full_goods_name'],
        brandName: json['brand_name'],
        manufacturerName: json['manufacturer_name'],
        unitWeight: json['unit_weight']);
  }
}
