import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:template_application/screens/auth_reg_pages/login_page.dart';
import 'package:template_application/screens/goods_pages/goods_detail.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/viewmodels/new_goods/new_goods_view_model.dart';
import 'package:dio/dio.dart';
import 'package:template_application/screens/main_page/main_page.dart';

class HorizontalListViewNewGoods extends StatelessWidget {
  final List<NewGoodsViewModel> newGoods;
  final int userId;
  final String regionId;

  HorizontalListViewNewGoods({this.newGoods, this.userId, this.regionId});

  @override
  Widget build(BuildContext context) {
    var newGoods = this.newGoods;

    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var newGoods in newGoods)
            NewGoods(
              goodsId: newGoods.goodsId,
              imageUrl:
                  "${Constants.baseUrl}images/goods/${newGoods.goodsAdjustedName}_0_preview.jpg",
              imageCaption: newGoods.goodsName,
              goodsPrice: newGoods.goodsPrice,
              count: newGoods.buyCount,
              goodsDescription: newGoods.goodsDescription,
              goodsAdjustedName: newGoods.goodsAdjustedName,
              packageSize: newGoods.packageSize,
              inMyBasket: newGoods.inMyBasketreId,
              userId: userId,
              storeId: newGoods.storeId,
              regionId: regionId,
              storeName: newGoods.storeName,
              fullGoodsName: newGoods.fullGoodsName,
              brandName: newGoods.brandName,
              manufacturerName: newGoods.manufacturerName,
              unitWeight: newGoods.unitWeight,
              measureUnitTxt: newGoods.measureUnitTxt,
            )
        ],
      ),
    );
  }
}

class NewGoods extends StatefulWidget {
  final String goodsId;
  final String imageUrl;
  final String imageCaption;
  final String goodsPrice;
  final String count;
  final String goodsDescription;
  final String goodsAdjustedName;
  final String packageSize;
  String inMyBasket;
  final int userId;
  final String storeId;
  final String regionId;
  final String storeName;
  final String fullGoodsName;
  final String brandName;
  final String manufacturerName;
  final String unitWeight;
  final String measureUnitTxt;

  NewGoods(
      {this.goodsId,
      this.imageUrl,
      this.imageCaption,
      this.goodsPrice,
      this.count,
      this.goodsDescription,
      this.goodsAdjustedName,
      this.packageSize,
      this.inMyBasket,
      this.userId,
      this.storeId,
      this.regionId,
      this.storeName,
      this.fullGoodsName,
      this.brandName,
      this.manufacturerName,
      this.unitWeight,
      this.measureUnitTxt});

  @override
  _NewGoodsState createState() => _NewGoodsState();
}

class _NewGoodsState extends State<NewGoods> {
  Color _buttonSetBasket = Constants.color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GoodsDetail(
                      goodsPrice: widget.goodsPrice,
                      goodsName: widget.imageCaption,
                      goodsDescription: widget.goodsDescription,
                      goodsAdjustedName: widget.goodsAdjustedName,
                      count: widget.count,
                      packageSize: widget.packageSize,
                      userId: widget.userId,
                      goodsId: widget.goodsId,
                      storeId: widget.storeId,
                      regionId: widget.regionId,
                      storeName: widget.storeName,
                      fullGoodsName: widget.fullGoodsName,
                      brandName: widget.brandName,
                      manufacturerName: widget.manufacturerName,
                      unitWeight: widget.unitWeight,
                      measureUnitTxt: widget.measureUnitTxt,
                    )));
          },
          child: Container(
            width: 172,
            child: ListTile(
                title: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Constants.color),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset("images/no_logo.png"),
                  height: 80,
                ),
                subtitle: Container(
                    alignment: Alignment.topCenter,
                    child: ListView(
                      children: <Widget>[
                        Text(
                          widget.imageCaption,
                          textAlign: TextAlign.center,
                          style:
                              new TextStyle(fontSize: 13, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${widget.goodsPrice} P. / ${widget.count} шт.",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: 13,
                                color: Constants.color,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          child: RaisedButton(
                            highlightColor: Color(0xFF00b3b3),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: widget.inMyBasket == '0'
                                        ? Constants.color
                                        : Constants.colorSecond)),
                            onPressed: () async {
                              if (widget.userId != -1) {
                                var dio = new Dio();
                                String url =
                                    "${Constants.baseUrl}api/v1/addBasket";

                                final Map<String, dynamic>
                                    _addBasketParameters = {
                                  "userId": widget.userId,
                                  "goodsId": widget.goodsId,
                                  "storeId": widget.storeId,
                                  "regionId": widget.regionId,
                                  "count": widget.count,
                                  "price": widget.goodsPrice
                                };

                                final response = await dio.post(url,
                                    data:
                                        FormData.fromMap(_addBasketParameters));

                                if (response.toString() == "true")
                                  setState(() {
                                    _buttonSetBasket = Colors.orange;
                                    widget.inMyBasket = "1";
                                  });
                                MainPage();
                              } else {
                                // Scaffold.of(context).showSnackBar(SnackBar(
                                //   content: Text("Необходимо авторизоваться!"),
                                // ));
                                Alert(
                                    context: context,
                                    title: "",
                                    desc:
                                        "Авторизуйтесь для добавления товара в корзину!",
                                    buttons: [
                                      DialogButton(
                                        color: Constants.color,
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return LoginPage();
                                          }));
                                        },
                                        child: Text(
                                          'Войти',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ]).show();
                              }
                            },
                            color: widget.inMyBasket == '0'
                                ? _buttonSetBasket
                                : Constants.colorSecond,
                            textColor: Colors.white,
                            child: widget.inMyBasket == '0'
                                ? Text("В корзину".toUpperCase(),
                                    style: TextStyle(fontSize: 14))
                                : Text("В корзине".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                          ),
                        )
                      ],
                    ))),
          )),
    );
  }
}
