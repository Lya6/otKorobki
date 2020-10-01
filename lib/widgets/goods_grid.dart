import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/screens/auth_reg_pages/login_page.dart';
import 'package:template_application/screens/goods_pages/goods_detail.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:template_application/screens/goods_pages/goods_list_page.dart';
import 'package:template_application/viewmodels/goods/goods_list_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_application/viewmodels/goods/goods_view_model.dart';
import 'package:template_application/viewmodels/subcategories/subcategories_list_view_model.dart';
import 'package:template_application/viewmodels/subcategories/subcategories_view_model.dart';

class GoodsGrid extends StatefulWidget {
  final List<GoodsViewModel> goods;
  final List<SubcategoriesViewModel> subcategories;

  final String categoryId;

  GoodsGrid({this.goods, this.subcategories, this.categoryId});

  @override
  _GoodsGridState createState() => _GoodsGridState();
}

class _GoodsGridState extends State<GoodsGrid> {
// class GoodsGrid extends StatelessWidget {
  Color _buttonSetBasket = Constants.color;
  String _choice;
  int userId;
  String region;

  // @ovveride
  // ignore: must_call_super
  void initState() {
    //goods = widget.goods;

    SharedPreferences.getInstance().then((prefs) {
      setState(() => userId = prefs.getInt('userId') ?? -1);
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() => region = prefs.getString('parentId') ?? "");
    });

    Provider.of<GoodsListViewModel>(context, listen: false)
        .goods(widget.categoryId, region, userId);

    Provider.of<SubcategoriesListViewModel>(context, listen: false)
        .subcategories(widget.categoryId, region, userId);
  }

  @override
  Widget build(BuildContext context) {
    var goods = Provider.of<GoodsListViewModel>(context);
    // var subcategories = Provider.of<SubcategoriesListViewModel>(context);
    // List<GoodsViewModel> _accountType = <GoodsViewModel>[];
    var _accountType = widget.subcategories;
    // for (int i = 0; i < goods.listGoods.length; i++)
    // goods.listGoods[i].goodsId,
    // ];

    switch (goods.loadingStatus.index) {
      case 1:
        {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Constants.color),
            ),
          );
        }
      case 0:
        return Scaffold(
            body: Container(
                width: double.infinity,
                child: _accountType.length > 0
                    ? Column(children: [
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: DropdownButton<SubcategoriesViewModel>(
                            items: _accountType
                                .map((value) => DropdownMenuItem(
                                      child: Text(value.name),
                                      value: value,
                                    ))
                                .toList(),
                            hint: Text(
                              "Выбрать категорию",
                              textAlign: TextAlign.center,
                            ),
                            onChanged: (SubcategoriesViewModel value) {
                              _choice = value.id;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          GoodsListPage(
                                            categoryId: _choice,
                                          )));
                              // return GoodsListPage(
                              //   categoryId: _choice,
                              // );
                              // }));
                            },
                            // onTap: () => print(items),
                          ),
                        ),
                        Expanded(
                            child: GridView.count(
                          crossAxisCount: 2,
                          children: <Widget>[
                            for (int i = 0; i < goods.listGoods.length; i++)
                              _buildCard(
                                  goods.listGoods[i].goodsName,
                                  goods.listGoods[i].goodsPrice,
                                  goods.listGoods[i].buyCount,
                                  goods.listGoods[i].goodsAdjustedName,
                                  i,
                                  goods.listGoods[i].goodsDescription,
                                  goods.listGoods[i].packageSize,
                                  context,
                                  goods.listGoods[i].inMyBasketreId,
                                  userId,
                                  goods.listGoods[i].storeId,
                                  goods.listGoods[i].goodsId,
                                  region,
                                  goods.listGoods[i].storeName,
                                  goods.listGoods[i].fullGoodsName,
                                  goods.listGoods[i].brandName,
                                  goods.listGoods[i].manufacturerName,
                                  goods.listGoods[i].unitWeight,
                                  goods.listGoods[i].measureUnitTxt)
                          ],
                        ))
                      ])
                    : GridView.count(
                        crossAxisCount: 2,
                        children: <Widget>[
                          for (int i = 0; i < goods.listGoods.length; i++)
                            _buildCard(
                                goods.listGoods[i].goodsName,
                                goods.listGoods[i].goodsPrice,
                                goods.listGoods[i].buyCount,
                                goods.listGoods[i].goodsAdjustedName,
                                i,
                                goods.listGoods[i].goodsDescription,
                                goods.listGoods[i].packageSize,
                                context,
                                goods.listGoods[i].inMyBasketreId,
                                userId,
                                goods.listGoods[i].storeId,
                                goods.listGoods[i].goodsId,
                                region,
                                goods.listGoods[i].storeName,
                                goods.listGoods[i].fullGoodsName,
                                goods.listGoods[i].brandName,
                                goods.listGoods[i].manufacturerName,
                                goods.listGoods[i].unitWeight,
                                goods.listGoods[i].measureUnitTxt)
                        ],
                      )));
      case 2:
      default:
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Constants.color),
          ),
        );
    }
  }

  Widget _buildCard(
      String name,
      String price,
      String count,
      String adjustedName,
      int cardIndex,
      String goodsDescription,
      String packageSize,
      BuildContext context,
      String inMyBasket,
      int userId,
      String storeId,
      String goodsId,
      String region,
      String storeName,
      String fullGoodsName,
      String brandName,
      String manufacturerName,
      String unitWeight,
      String measureUnitTxt) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 7.0,
            child: Column(
              children: <Widget>[
                SizedBox(height: 5.0),
                Stack(children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GoodsDetail(
                                goodsPrice: price ?? "",
                                goodsName: name ?? "",
                                goodsDescription: goodsDescription ?? "",
                                goodsAdjustedName: adjustedName ?? "",
                                count: count ?? "",
                                packageSize: packageSize ?? "",
                                userId: userId ?? "",
                                goodsId: goodsId ?? "",
                                storeId: storeId ?? "",
                                regionId: region ?? "",
                                storeName: storeName ?? "",
                                fullGoodsName: fullGoodsName ?? "",
                                brandName: brandName ?? "",
                                manufacturerName: manufacturerName ?? "",
                                unitWeight: unitWeight ?? "",
                                measureUnitTxt: measureUnitTxt ?? "",
                              )));
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          "${Constants.baseUrl}images/goods/${adjustedName}_0_preview.jpg",
                      placeholder: (context, url) => CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Constants.color),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset("images/no_logo.png"),
                      height: 80,
                    ),
                  )
                ]),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GoodsDetail(
                              goodsPrice: price ?? "",
                              goodsName: name ?? "",
                              goodsDescription: goodsDescription ?? "",
                              goodsAdjustedName: adjustedName ?? "",
                              count: count ?? "",
                              packageSize: packageSize ?? "",
                              userId: userId ?? "",
                              goodsId: goodsId ?? "",
                              storeId: storeId ?? "",
                              regionId: region ?? "",
                              storeName: storeName ?? "",
                              fullGoodsName: fullGoodsName ?? "",
                              brandName: brandName ?? "",
                              manufacturerName: manufacturerName ?? "",
                              unitWeight: unitWeight ?? "",
                              measureUnitTxt: measureUnitTxt ?? "",
                            )));
                  },
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Text(
                  "$price ₽/ ${double.parse(count).toStringAsFixed(2)} шт.",
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Constants.color),
                ),
                SizedBox(height: 5.0),
                Expanded(
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: inMyBasket == '0'
                              ? Constants.color
                              : Constants.colorSecond,
                          //status == 'Away' ? Colors.grey : Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                        child: FlatButton(
                            onPressed: () async {
                              if (userId != -1) {
                                var dio = new Dio();
                                String url =
                                    "${Constants.baseUrl}api/v1/addBasket";

                                final Map<String, dynamic>
                                    _addBasketParameters = {
                                  "userId": userId,
                                  "goodsId": goodsId,
                                  "storeId": storeId,
                                  "regionId": region,
                                  "count": count,
                                  "price": price
                                };

                                final response = await dio.post(url,
                                    data:
                                        FormData.fromMap(_addBasketParameters));

                                print(response);

                                setState(() {
                                  _buttonSetBasket = Colors.orange;
                                });

                                Provider.of<GoodsListViewModel>(context,
                                        listen: false)
                                    .goods(widget.categoryId, region, userId);
                              } else {
                                //showAlertDialog(context);
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
                            child: Center(
                              child: Text(
                                inMyBasket == "0" ? 'В корзину' : "В корзине",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Quicksand'),
                              ),
                            ))))
              ],
            ),
            margin: cardIndex.isEven
                ? EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0)
                : EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0)));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
        child: Text(
          "OK",
          style: TextStyle(color: Constants.color),
        ),
        onPressed: () => Navigator.pop(context));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ошибка"),
      content: Text("Необходимо авторизоваться!"),
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

  Future<void> funcAsync() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
