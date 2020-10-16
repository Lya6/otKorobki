import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_application/constants.dart';
import 'package:provider/provider.dart';
import 'package:template_application/screens/thank_page.dart';
import 'package:template_application/viewmodels/address/address_list_view_model.dart';

class AddressPage extends StatefulWidget {
  final String typePay, parentId, storeId;
  final String type;
  final int userId;
  final BuildContext ctx;

  AddressPage(
      {this.userId,
      this.parentId,
      this.typePay,
      this.type,
      this.storeId,
      this.ctx});
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  SharedPreferences sharedPreferences;
  int userId = -1;
  @override
  void initState() {
    super.initState();

    funcAsync();

    SharedPreferences.getInstance().then((prefs) {
      setState(() => userId = prefs.getInt('userId') ?? -1);
    });
  }

  final address = TextEditingController();
  final comment = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    address.dispose();
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<AddressListViewModel>(context);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Constants.color,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              "Адреса доставок",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      showAlert(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 26.0,
                    ),
                  ))
            ]),
        body: Builder(builder: (BuildContext ctxx) {
          return Container(child: FutureBuilder(builder: (context, snapshot) {
            return listViewModel.listAddress.length > 0
                ? ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: listViewModel.listAddress.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(listViewModel.listAddress[index].address),
                          onTap: () async {
                            if (widget.type == "1") {
                              var dio = new Dio();
                              String url =
                                  "${Constants.baseUrl}api/v1/confirmOrderMobile";

                              final Map<String, dynamic> _payParameters = {
                                "userId": widget.userId,
                                "storeId": widget.storeId,
                                "comment": "no",
                                "deliveryId":
                                    listViewModel.listAddress[index].id,
                                "typeDelivery": widget.type,
                                "typePayment": widget.typePay,
                                "source": Platform.isAndroid ? "5" : "4"
                              };

                              final response = await dio.post(url,
                                  data: FormData.fromMap(_payParameters));

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ThankPage(
                                          number: response.data["natural_id"]
                                              .toString(),
                                          typePay: widget.typePay,
                                          url: response.data["url"].toString(),
                                        )),
                                (Route<dynamic> route) => false,
                              );
                            }
                          });
                    })
                : Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: () => print("asd"),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xFF00b3b3))),
                        onPressed: () {
                          // print(userId);
                          // print(listViewModel.listAddress.length);

                          showAlert(widget.ctx);
                        },
                        color: Constants.color,
                        textColor: Colors.white,
                        child: Text("Добавить адрес доставки".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  );
          }));
        }));
  }

  addAddress() async {
    var dio = new Dio();
    String url = "${Constants.baseUrl}api/v1/addDeliveryAddress";

    final Map<String, dynamic> _addressParameters = {
      "userId": userId,
      "address": address.text
    };

    final response =
        await dio.post(url, data: FormData.fromMap(_addressParameters));
    print(response);
  }

  showAlert(BuildContext context) {
    Alert(
        context: context,
        title: "Добавить новый адрес",
        content: Column(
          children: <Widget>[
            TextField(
              controller: address,
              decoration: InputDecoration(
                labelText: 'Адрес',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Constants.color,
            onPressed: () {
              // final NavigationService
              addAddress();
              Timer(Duration(seconds: 3), () {
                Provider.of<AddressListViewModel>(context, listen: false)
                    .address(userId);
                Navigator.of(context, rootNavigator: true).pop();
              });
            },
            child: Text(
              'Добавить адрес',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();

    //   // set up the button
    //   Widget okButton = FlatButton(
    //     child: Text(
    //       "Создать",
    //       style: TextStyle(color: Color(0xFF00b3b3)),
    //     ),
    //     onPressed: () {
    //       addAddress();
    //       //if (response.data["error"] == "") {
    //       //AddressPage();

    //       // await Navigator.push(
    //       //   context,
    //       //   MaterialPageRoute(builder: (context) => AddressPage()),
    //       // );

    //       Timer(Duration(seconds: 1), () {
    //         Navigator.of(context).pop();
    //         Provider.of<AddressListViewModel>(context, listen: false)
    //             .address(userId);
    //       });

    //       // Navigator.of(context).pop();
    //       // setState(() {});

    //       // else {
    //       //   showAlertErrorDialog(context, response.data["error"]);
    //       // }
    //     },
    //   );

    //   Widget cancelButton = FlatButton(
    //     child: Text(
    //       "Отмена",
    //       style: TextStyle(color: Color(0xFF00b3b3)),
    //     ),
    //     onPressed: () {
    //       Timer(Duration(seconds: 1), () {
    //         Navigator.pop(context);
    //       });
    //     },
    //   );

    //   // set up the AlertDialog
    //   AlertDialog alert = AlertDialog(
    //     title: Text("Новый адрес"),
    //     content: Container(
    //         height: 150,
    //         child: Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Column(children: [
    //               TextField(
    //                   controller: address,
    //                   decoration: InputDecoration(
    //                       hintText: 'Адрес',
    //                       focusedBorder: UnderlineInputBorder(
    //                           borderSide: BorderSide(color: Colors.red)))),
    //               TextField(
    //                   controller: comment,
    //                   decoration: InputDecoration(
    //                       hintText: 'Комментарий',
    //                       focusedBorder: UnderlineInputBorder(
    //                           borderSide: BorderSide(color: Colors.red)))),
    //             ]))),
    //     actions: [
    //       cancelButton,
    //       okButton,
    //     ],
    //   );

    //   // show the dialog
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return alert;
    //     },
    //   );
    // }

    // showAlertErrorDialog(BuildContext context, String error) {
    //   // set up the button
    //   Widget okButton = FlatButton(
    //     child: Text(
    //       "OK",
    //       style: TextStyle(color: Colors.red),
    //     ),
    //     onPressed: () {
    //       Navigator.of(context).pop();
    //     },
    //   );

    //   // set up the AlertDialog
    //   AlertDialog alert = AlertDialog(
    //     title: Text("Ошибка"),
    //     content: Text(error),
    //     actions: [
    //       okButton,
    //     ],
    //   );

    //   // show the dialog
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return alert;
    //     },
    //   );
  }

  Future<void> funcAsync() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getInt("userId") ?? -1;
    Provider.of<AddressListViewModel>(context, listen: false).address(userId);
  }
}
