import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_application/viewmodels/goods_in_order/goods_in_order_list_view_model.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/viewmodels/goods_order/goods_order_list_view_model.dart';

class GoodsOrderPage extends StatefulWidget {
  final int userId;
  final String orderId;

  GoodsOrderPage({this.userId, this.orderId});

  @override
  _GoodsOrderPageState createState() => _GoodsOrderPageState();
}

class _GoodsOrderPageState extends State<GoodsOrderPage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    funcAsync();
  }

  @override
  Widget build(BuildContext context) {
    final listViewModel = Provider.of<GoodsOrderListViewModel>(context);

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
      body: ListView.builder(
          itemCount: listViewModel.listGoodsOrder.length,
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
                      child: Image.network(
                        "${Constants.baseUrl}images/goods/${listViewModel.listGoodsOrder[index].goodsAdjustedName}_0_preview.jpg",
                        height: double.infinity,
                        width: 90,
                        fit: BoxFit.contain,
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
                              maxLines: 5,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: listViewModel
                                        .listGoodsOrder[index].goodsName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        "\n\n${listViewModel.listGoodsOrder[index].priceInOrder} ₽              ${listViewModel.listGoodsOrder[index].countInOrder} шт.\n\n",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300)),
                              ]),
                            ),
                          ])))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<void> funcAsync() async {
    WidgetsFlutterBinding.ensureInitialized();
    Provider.of<GoodsOrderListViewModel>(context, listen: false)
        .goodsOrder(widget.userId, widget.orderId);
  }
}
