import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:template_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flushbar/flushbar.dart';
import 'package:template_application/screens/auth_reg_pages/login_page.dart';

class GoodsDetail extends StatefulWidget {
  final goodsPrice,
      goodsName,
      goodsDescription,
      goodsAdjustedName,
      count,
      packageSize,
      userId,
      goodsId,
      storeId,
      regionId,
      storeName,
      fullGoodsName,
      brandName,
      manufacturerName,
      unitWeight,
      measureUnitTxt;

  GoodsDetail(
      {this.goodsPrice,
      this.goodsName,
      this.goodsDescription,
      this.goodsAdjustedName,
      this.count,
      this.packageSize,
      this.userId,
      this.goodsId,
      this.storeId,
      this.regionId,
      this.storeName,
      this.fullGoodsName,
      this.brandName,
      this.manufacturerName,
      this.unitWeight,
      this.measureUnitTxt});

  @override
  _GoodsDetail createState() => _GoodsDetail();
}

class _GoodsDetail extends State<GoodsDetail> {
  double rez;
  int userId;
  String region;
  @override
  void initState() {
    rez = double.parse(widget.count);

    SharedPreferences.getInstance().then((prefs) {
      setState(() => userId = prefs.getInt('userId') ?? -1);
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() => region = prefs.getString('parentId') ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(children: [
          SizedBox(height: 15.0),
          SizedBox(
            height: 150,
            child: CachedNetworkImage(
              imageUrl:
                  "${Constants.baseUrl}images/goods/${widget.goodsAdjustedName}_0_preview.jpg",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.asset("images/no_logo.png"),
              height: 80,
              // width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Text(widget.fullGoodsName,
                style: TextStyle(
                    color: Color(0xFF575E67),
                    fontFamily: 'Varela',
                    fontSize: 24.0)),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      "${double.parse((double.parse(widget.goodsPrice) * double.parse(widget.count)).toString()).toStringAsFixed(1)} ₽ / ${double.parse(widget.count).toStringAsFixed(1)} шт.",
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Constants.color)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      "${double.parse((double.parse(widget.goodsPrice) * double.parse(widget.packageSize)).toString()).toStringAsFixed(1)} ₽ / ${double.parse(widget.packageSize).toStringAsFixed(1)} шт.",
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          if (widget.goodsDescription != null)
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  child: (Html(data: widget.goodsDescription))),
            ),
          Container(
            height: 35,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Продавец:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  Flexible(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(widget.storeName ?? "",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))))
                ]),
          ),
          Container(
            height: 35,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Бренд:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  Flexible(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(widget.brandName ?? "",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))))
                ]),
          ),
          Container(
            height: 35,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Производитель:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  Flexible(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(widget.manufacturerName ?? "",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))))
                ]),
          ),
          SizedBox(height: 10.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Тип упаковки:",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                        "${double.parse(widget.count).toStringAsFixed(2)} шт. x ${double.parse(widget.unitWeight).toStringAsFixed(2)} ${widget.measureUnitTxt}." ??
                            "",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)))
              ]),
          SizedBox(height: 10.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Вес упаковки:",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                        "${double.parse((double.parse(widget.unitWeight) * double.parse(widget.count)).toString()).toStringAsFixed(2)} ${widget.measureUnitTxt}." ??
                            "",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)))
              ]),
          SizedBox(height: 20.0),
          if (widget.userId == -1)
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Constants.color),
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(
                            onPressed: () {
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
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                            },
                            child: Center(
                                child: Text(
                              'Чтобы добавить товар в корзину, нужно авторизоваться',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Varela',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ))))))
          else
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    buildOutlineButton(
                      icon: Icons.remove,
                      press: () {
                        if (rez > double.parse(widget.count)) {
                          setState(() {
                            rez -= double.parse(widget.count);
                          });
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50 / 2),
                      child: Text(
                        // if our item is less  then 10 then  it shows 01 02 like that
                        // numOfItems.toString().padLeft(2, "0"),
                        "${double.parse(rez.toString()).toStringAsFixed(1)}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    buildOutlineButton(
                        icon: Icons.add,
                        press: () {
                          setState(() {
                            rez += double.parse(widget.count);
                          });
                        })
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Constants.color),
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FlatButton(
                                onPressed: () {
                                  aaaaa();
                                  // Scaffold.of(context).showSnackBar(SnackBar(
                                  //   content: Text("Необходимо авторизоваться!"),
                                  // ));
                                  Flushbar(
                                    message:
                                        "Товар успешно добавлен в корзину!",
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                  // showAlertDialog(context,
                                  //     "Товар успешно добавлен в корзину!");
                                },
                                child: Center(
                                    child: Text(
                                  'В корзину',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ))))),
                  )
                ]),
          SizedBox(height: 40.0)

          // CartCounter(),
        ])

        // bottomNavigationBar: BottomBar(),
        );
  }

  aaaaa() {
    var dio = new Dio();
    String url = "${Constants.baseUrl}api/v1/addBasket";

    final Map<String, dynamic> _addBasketParameters = {
      "userId": userId,
      "goodsId": widget.goodsId,
      "storeId": widget.storeId,
      "regionId": region,
      "count": rez,
      "price": widget.goodsPrice
    };

    var response = dio.post(url, data: FormData.fromMap(_addBasketParameters));
    //print(response.data.toString());
  }

  showAlertDialog(BuildContext contex, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        aaaaa();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Сообщение"),
      content: Text(message),
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
}
