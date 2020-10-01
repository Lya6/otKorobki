import 'package:flutter/material.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/screens/profile_page/goods_order_page.dart';
import 'package:template_application/viewmodels/order_list/order_list_view_model.dart';

class OrdersGrid extends StatelessWidget {
  final List<OrderListViewModel> orders;
  final int userId;
  // final String region;

  OrdersGrid({this.orders, this.userId});

  @override
  Widget build(BuildContext context) {
    var orders = this.orders;

    return GridView.count(
      crossAxisCount: 1,
      children: <Widget>[
        for (int i = 0; i < orders.length; i++)
          _buildCard(i, userId, orders[i].dateCreate, orders[i].deliveryType,
              orders[i].orderSum, i, context)
      ],
    );
  }

  Widget _buildCard(int cardIndex, int userId, String dateCreate,
      String deliveryType, String orderSum, int index, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
            height: double.infinity,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 7.0,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Stack(children: <Widget>[
                      Center(
                        child: Text(
                          "Дата оформления заказа: \n$dateCreate",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      FlatButton(
                          onPressed: () => print("asdasd"),
                          child: Container(
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: Center(
                                      child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GoodsOrderPage(
                                                    userId: userId,
                                                    orderId: orders[index]
                                                        .numberOrder,
                                                  )));
                                    },
                                    child: Image(
                                      color: Constants.color,
                                      image: deliveryType == "1"
                                          ? AssetImage("images/recipient.png")
                                          : AssetImage("images/shipment.png"),
                                      height: 180,
                                    ),
                                  )))))
                    ]),

                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GoodsOrderPage(
                                  userId: userId,
                                  orderId: orders[index].numberOrder,
                                )));
                      },
                      child: Text(
                        deliveryType == "1"
                            ? "Тип доставки: Самовывоз"
                            : "Тип доставки: Доставка",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),

                    Text(
                      "Статус заказа: $deliveryType",
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),

                    Text(
                      "Сумма заказа: $orderSum ₽",
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    // SizedBox(height: 5.0),
                    // Expanded(
                    //     child: Container(
                    //         width: 175.0,
                    //         decoration: BoxDecoration(
                    //           color: Colors.red,
                    //           //status == 'Away' ? Colors.grey : Colors.green,
                    //           borderRadius: BorderRadius.only(
                    //               bottomLeft: Radius.circular(10.0),
                    //               bottomRight: Radius.circular(10.0)),
                    //         ),
                    //         child: FlatButton(
                    //             onPressed: () async {
                    //               // // if (userId != -1) {
                    //               // //   var dio = new Dio();
                    //               // //   String url =
                    //               // //       "${Constants.baseUrl}api/v1/addBasket";

                    //               // //   final Map<String, dynamic>
                    //               // //       _addBasketParameters = {
                    //               // //     "userId": userId,
                    //               // //     "goodsId": goodsId,
                    //               // //     "storeId": storeId,
                    //               // //     "regionId": region,
                    //               // //     "count": count,
                    //               // //     "price": price
                    //               // //   };

                    //               // //   final response = await dio.post(url,
                    //               // //       data:
                    //               // //           FormData.fromMap(_addBasketParameters));

                    //               // //   print(response);
                    //               // } else {
                    //               //   showAlertDialog(
                    //               //       context, "Необходимо авторизоваться!");
                    //               // }
                    //             },
                    //             child: Center(
                    //               child: Text(
                    //                 'В корзину',
                    //                 style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontFamily: 'Quicksand'),
                    //               ),
                    //             ))))
                  ],
                ),
                margin: cardIndex.isEven
                    ? EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0)
                    : EdgeInsets.fromLTRB(15.0, 0.0, 5.0, 0.0))));
  }

  showAlertDialog(BuildContext context, String error) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ошибка"),
      content: Text(error),
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
}
