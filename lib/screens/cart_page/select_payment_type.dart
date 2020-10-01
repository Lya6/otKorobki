import 'package:flutter/material.dart';
import 'package:template_application/widgets/select_type_payment_grid.dart';
import 'package:dio/dio.dart';
import 'package:template_application/constants.dart';

import 'goods_in_order_page.dart';

class SelectPaymentTypePage extends StatefulWidget {
  final String storeId;
  final int userId;
  final String parentId;
  final String storeAddressPickup;
  final String minSumPickup, minSumDelivery;

  SelectPaymentTypePage(
      {this.storeId,
      this.userId,
      this.parentId,
      this.storeAddressPickup,
      this.minSumPickup,
      this.minSumDelivery});

  @override
  _SelectPaymentTypePageState createState() => _SelectPaymentTypePageState();
}

class _SelectPaymentTypePageState extends State<SelectPaymentTypePage> {
  @override
  void initState() {
    super.initState();
    // funcAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.color,
        elevation: 1,
        centerTitle: true,
        title: Text("Выбор типа доставки"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SelectTypePaymentGrid(
        userId: widget.userId,
        parentId: widget.parentId,
        storeId: widget.storeId,
        minSumPickup: widget.minSumPickup,
        minSumDelivery: widget.minSumDelivery,
        storeAddressPickup: widget.storeAddressPickup,
      ),
    );
  }

  // Future<void> funcAsync() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   var dio = new Dio();

  //   String url =
  //       "${Constants.baseUrl}api/v1/getMinAmountDelivery/${widget.storeId}/${widget.parentId}";

  //   final response = await dio.get(url);
  //   print(response.data["minSumPickup"]);
  //   minSumPickup = response.data["minSumPickup"];
  //   minSumDelivery = response.data["minSumDelivery"];
  // }
}
