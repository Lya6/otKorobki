import 'package:flutter/material.dart';
import 'package:template_application/screens/cart_page/goods_in_order_page.dart';

class SelectTypePaymentGrid extends StatelessWidget {
  final int userId;
  final String parentId;
  final String storeId;
  final String minSumPickup;
  final String minSumDelivery;
  final String storeAddressPickup;
  // final String region;

  SelectTypePaymentGrid(
      {this.userId,
      this.parentId,
      this.storeId,
      this.minSumPickup,
      this.minSumDelivery,
      this.storeAddressPickup});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      children: <Widget>[
        _buildCard(
            0, storeAddressPickup, minSumPickup, minSumDelivery, context),
      ],
    );
  }

  Widget _buildCard(int typePayment, String address, String minSummPickUp,
      String minSummDevilery, BuildContext context) {
    return (Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GoodsInOrderScreen(
                          userId: userId,
                          parentId: parentId,
                          storeId: storeId,
                          minSum: "1",
                          type: 1,
                        )))
              },
              child: Container(
                height: 180.0,
                width: 350.0,
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey[500]),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(children: <Widget>[
                      Text(
                        "Доставка",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text(
                          "Минимальная сумма заказа: $minSummDevilery руб.",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ])),
              ),
            ),
            FlatButton(
                onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GoodsInOrderScreen(
                                userId: userId,
                                parentId: parentId,
                                storeId: storeId,
                                minSum: "1",
                                type: 0,
                              )))
                    },
                child: Container(
                    height: 180.0,
                    width: 350.0,
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey[500]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(children: <Widget>[
                          Text(
                            "Самовывоз",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Адрес: $address",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Минимальная сумма заказа: $minSummDevilery руб.",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]))))
          ],
        ))));
  }

  Future<void> lol(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => new GoodsInOrderScreen(
              userId: userId,
              parentId: parentId,
              storeId: storeId,
              minSum: "0",
              type: 0,
            )));
  }
}
