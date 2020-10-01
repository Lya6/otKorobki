import 'package:flutter/material.dart';
import 'package:template_application/screens/cart_page/goods_in_order_page.dart';
import 'package:dio/dio.dart';
import 'package:template_application/constants.dart';

class CartCounter extends StatefulWidget {
  final double count, step;
  final int userId;
  final String goodsId;
  CartCounter({this.count, this.step, this.userId, this.goodsId});
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  double rez;
  @override
  void initState() {
    rez = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () async {
            if (rez > widget.step) {
              setState(() {
                rez -= widget.step;
              });
              var dio = new Dio();

              String url = "${Constants.baseUrl}api/v1/updateItemBasket";

              final Map<String, dynamic> _goodsInOrderParameters = {
                "userId": widget.userId,
                "goodsId": widget.goodsId,
                "count": rez
              };

              final response = await dio.post(url,
                  data: FormData.fromMap(_goodsInOrderParameters));
              print(response.data);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50 / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            // numOfItems.toString().padLeft(2, "0"),
            rez.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () async {
              setState(() {
                rez += widget.step;
                // GoodsInOrderScreen(
                //   userId: 149,
                //   parentId: "7267",
                //   storeId: "1",
                //   minSum: "0",
                //   type: 0,
                // );
              });
              var dio = new Dio();

              String url = "${Constants.baseUrl}api/v1/updateItemBasket";

              final Map<String, dynamic> _goodsInOrderParameters = {
                "userId": widget.userId,
                "goodsId": widget.goodsId,
                "count": rez
              };

              final response = await dio.post(url,
                  data: FormData.fromMap(_goodsInOrderParameters));
              print(response.data);
            }),
      ],
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
