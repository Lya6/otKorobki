import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_application/main.dart';
import 'package:template_application/screens/thank_page.dart';
import 'package:template_application/viewmodels/goods_in_order/goods_in_order_list_view_model.dart';
import 'package:template_application/constants.dart';
import 'package:dio/dio.dart';
import 'package:template_application/screens/profile_page/address_page.dart';
import 'package:flushbar/flushbar.dart';

class GoodsInOrderScreen extends StatefulWidget {
  final int userId;
  final String parentId;
  final String storeId;
  final String minSum;
  final int type;

  GoodsInOrderScreen(
      {this.userId, this.parentId, this.storeId, this.minSum, this.type});

  @override
  _GoodsInOrderScreenState createState() => _GoodsInOrderScreenState();
}

class _GoodsInOrderScreenState extends State<GoodsInOrderScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    funcAsync();
  }

  @override
  Widget build(BuildContext context) {
    final listViewModel = Provider.of<GoodsInOrderListViewModel>(context);

    switch (listViewModel.loadingStatus.index) {
      case 1:
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      case 0:
        {
          return Scaffold(
            key: _key,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            backgroundColor: Colors.white,
            body: listViewModel.listGoodsInOrder.length > 0
                ? ListView.builder(
                    itemCount: listViewModel.listGoodsInOrder.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          height: 135,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.red.withOpacity(0.2),
                                    offset: Offset(3, 2),
                                    blurRadius: 30)
                              ]),
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${Constants.baseUrl}images/goods/${listViewModel.listGoodsInOrder[index].goodsAdjustedName}_0_preview.jpg",
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Constants.color),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset("images/no_logo.png"),
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                            child: Column(children: [
                                      RichText(
                                        maxLines: 4,
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: listViewModel
                                                  .listGoodsInOrder[index]
                                                  .goodsName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  "\n${double.parse((double.parse(listViewModel.listGoodsInOrder[index].goodsPrice) * double.parse(listViewModel.listGoodsInOrder[index].countInBasket)).toString()).toStringAsFixed(2)} ₽              ${double.parse((double.parse(listViewModel.listGoodsInOrder[index].countInBasket) * double.parse(listViewModel.listGoodsInOrder[index].goodsUnitWeight)).toString()).toStringAsFixed(2)} ${listViewModel.listGoodsInOrder[index].goodsMeasureUnitTxt}\n\n",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w300)),
                                        ]),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                buildOutlineButton(
                                                  icon: Icons.remove,
                                                  press: () async {
                                                    if (double.parse(listViewModel
                                                            .listGoodsInOrder[
                                                                index]
                                                            .countInBasket) >
                                                        double.parse(listViewModel
                                                            .listGoodsInOrder[
                                                                index]
                                                            .buyCount)) {
                                                      // setState(() {
                                                      //   rez -= widget.step;
                                                      // });
                                                      var dio = new Dio();

                                                      String url =
                                                          "${Constants.baseUrl}api/v1/updateItemBasket";

                                                      final Map<String, dynamic>
                                                          _goodsInOrderParameters =
                                                          {
                                                        "userId": widget.userId,
                                                        "goodsId": listViewModel
                                                            .listGoodsInOrder[
                                                                index]
                                                            .goodsId,
                                                        "count": double.parse(
                                                                listViewModel
                                                                    .listGoodsInOrder[
                                                                        index]
                                                                    .countInBasket) -
                                                            double.parse(
                                                                listViewModel
                                                                    .listGoodsInOrder[
                                                                        index]
                                                                    .buyCount)
                                                      };

                                                      final response = await dio.post(
                                                          url,
                                                          data: FormData.fromMap(
                                                              _goodsInOrderParameters));
                                                      print(response.data);
                                                      funcAsync();
                                                    }
                                                  },
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 50 / 2),
                                                  child: Text(
                                                    // if our item is less  then 10 then  it shows 01 02 like that
                                                    // numOfItems.toString().padLeft(2, "0"),
                                                    listViewModel
                                                        .listGoodsInOrder[index]
                                                        .countInBasket,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                ),
                                                buildOutlineButton(
                                                    icon: Icons.add,
                                                    press: () async {
                                                      var dio = new Dio();

                                                      String url =
                                                          "${Constants.baseUrl}api/v1/updateItemBasket";

                                                      final Map<String, dynamic>
                                                          _goodsInOrderParameters =
                                                          {
                                                        "userId": widget.userId,
                                                        "goodsId": listViewModel
                                                            .listGoodsInOrder[
                                                                index]
                                                            .goodsId,
                                                        "count": double.parse(
                                                                listViewModel
                                                                    .listGoodsInOrder[
                                                                        index]
                                                                    .countInBasket) +
                                                            double.parse(
                                                                listViewModel
                                                                    .listGoodsInOrder[
                                                                        index]
                                                                    .buyCount)
                                                      };

                                                      final response = await dio.post(
                                                          url,
                                                          data: FormData.fromMap(
                                                              _goodsInOrderParameters));
                                                      print(response.data);
                                                      funcAsync();
                                                    }),
                                              ],
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () async {
                                                  print(listViewModel
                                                      .listGoodsInOrder.length
                                                      .toString());
                                                  var dio = new Dio();

                                                  String url =
                                                      "${Constants.baseUrl}api/v1/deleteItemBasket";

                                                  final Map<String, dynamic>
                                                      _goodsInOrderParameters =
                                                      {
                                                    "userId": widget.userId,
                                                    "goodsId": listViewModel
                                                        .listGoodsInOrder[index]
                                                        .goodsId
                                                  };

                                                  final response = await dio.post(
                                                      url,
                                                      data: FormData.fromMap(
                                                          _goodsInOrderParameters));

                                                  print(response);

                                                  if (listViewModel
                                                          .listGoodsInOrder
                                                          .length >
                                                      1)
                                                    funcAsync();
                                                  else {
                                                    // Navigator.of(context).pop();
                                                    // showAlertDialog(context);
                                                    Flushbar(
                                                      message:
                                                          "В корзине нет товара от данного поставщика!",
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ).show(context);

                                                    Timer(Duration(seconds: 2),
                                                        () {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyAppSecond()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false,
                                                      );
                                                    });
                                                  }
                                                }),
                                          ])
                                    ])))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text("data"),
                  ),
            bottomNavigationBar: Container(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Итого: ${listViewModel.listGoodsInOrder[0].totalSumBasket} ₽",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 22,
                                fontWeight: FontWeight.w400)),
                      ]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Constants.color),
                      child: FlatButton(
                          onPressed: () {
                            _showSimpleDialog();
                          },
                          child: Text(
                            "Заказать",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      case 2:
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    }
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }

  Future<void> funcAsync() async {
    //WidgetsFlutterBinding.ensureInitialized();
    Provider.of<GoodsInOrderListViewModel>(context, listen: false)
        .goodsInOrder(widget.userId, widget.storeId, widget.parentId);
  }

  showAlertDialog(BuildContext contex) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyAppSecond()),
          (Route<dynamic> route) => false,
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Сообщение"),
      content: Text("В корзине больше товаров нет!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showSimpleDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Выбор способа оплаты'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: SimpleDialogOption(
                  onPressed: () async {
                    if (widget.type == 1) {
                      var dio = new Dio();
                      String url =
                          "${Constants.baseUrl}api/v1/confirmOrderMobile";

                      final Map<String, dynamic> _payParameters = {
                        "userId": widget.userId,
                        "storeId": widget.storeId,
                        "comment": "no",
                        "deliveryId": -1,
                        "typeDelivery": widget.type,
                        "source": 0,
                        "typePayment": 1
                      };

                      final response = await dio.post(url,
                          data: FormData.fromMap(_payParameters));

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThankPage(
                                  number:
                                      response.data["natural_id"].toString(),
                                  typePay: "1",
                                )),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AddressPage(
                                    type: "0",
                                    userId: widget.userId,
                                    parentId: widget.parentId,
                                    typePay: "1",
                                    storeId: widget.storeId,
                                  )));
                    }
                    // _dismissDialog();
                  },
                  child: const Text('Наличными'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SimpleDialogOption(
                  onPressed: () async {
                    if (widget.type == 1) {
                      var dio = new Dio();
                      String url =
                          "${Constants.baseUrl}api/v1/confirmOrderMobile";

                      final Map<String, dynamic> _payParameters = {
                        "userId": widget.userId,
                        "storeId": widget.storeId,
                        "comment": "no",
                        "deliveryId": 0,
                        "typeDelivery": widget.type,
                        "typePayment": 2
                      };

                      final response = await dio.post(url,
                          data: FormData.fromMap(_payParameters));

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThankPage(
                                  number:
                                      response.data["natural_id"].toString(),
                                  typePay: "2",
                                )),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AddressPage(
                                    type: "0",
                                    userId: widget.userId,
                                    parentId: widget.parentId,
                                    typePay: "2",
                                    storeId: widget.storeId,
                                  )));
                    }

                    // _dismissDialog();
                  },
                  child: const Text('Картой при получении'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SimpleDialogOption(
                  onPressed: () async {
                    if (widget.type == 1) {
                      var dio = new Dio();
                      String url =
                          "${Constants.baseUrl}api/v1/confirmOrderMobile";

                      final Map<String, dynamic> _payParameters = {
                        "userId": widget.userId,
                        "storeId": widget.storeId,
                        "comment": "no",
                        "deliveryId": 0,
                        "typeDelivery": widget.type,
                        "typePayment": 3
                      };

                      final response = await dio.post(url,
                          data: FormData.fromMap(_payParameters));

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThankPage(
                                  number:
                                      response.data["natural_id"].toString(),
                                  typePay: "3",
                                )),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AddressPage(
                                    type: "0",
                                    userId: widget.userId,
                                    parentId: widget.parentId,
                                    typePay: "3",
                                    storeId: widget.storeId,
                                  )));
                    }
                    // _dismissDialog();
                  },
                  child: const Text('Оплата по счёту'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SimpleDialogOption(
                  onPressed: () async {
                    if (widget.type == 1) {
                      var dio = new Dio();
                      String url =
                          "${Constants.baseUrl}api/v1/confirmOrderMobile";

                      final Map<String, dynamic> _payParameters = {
                        "userId": widget.userId,
                        "storeId": widget.storeId,
                        "comment": "no",
                        "deliveryId": 0,
                        "typeDelivery": widget.type,
                        "typePayment": 4
                      };

                      final response = await dio.post(url,
                          data: FormData.fromMap(_payParameters));

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThankPage(
                                  number:
                                      response.data["natural_id"].toString(),
                                  typePay: "4",
                                  url: response.data["url"].toString(),
                                )),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AddressPage(
                                    type: "0",
                                    userId: widget.userId,
                                    parentId: widget.parentId,
                                    typePay: "4",
                                    storeId: widget.storeId,
                                  )));
                    }
                    // _dismissDialog();
                  },
                  child: const Text('Оплата картой на сайте'),
                ),
              )
            ],
          );
        });
  }
}
