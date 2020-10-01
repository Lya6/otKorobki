import 'package:flutter/material.dart';
import 'package:template_application/main.dart';
import 'package:template_application/screens/choice_region_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class ThankPage extends StatefulWidget {
  final String number, typePay, url;

  ThankPage({this.number, this.typePay, this.url});
  @override
  _ThankPageState createState() => _ThankPageState();
}

class _ThankPageState extends State<ThankPage> {
  @override
  void initState() {
    super.initState();
    if (widget.typePay == "4") launch(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Благодарим за заказ. Ожидайте звонка оператора для подтверждения заказа. \n Ваш номер заказа: ${widget.number}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyAppSecond()),
            (Route<dynamic> route) => false,
          );

          // ChoiceRegionPage();
        },
        label: Text("       ВЕРНУТЬСЯ К ВЫБОРУ ТОВАРА       "),
        backgroundColor: Constants.color,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
