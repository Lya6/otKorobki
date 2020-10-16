import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:template_application/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  SharedPreferences sharedPreferences;
  int userId = -1;
  String firstname = "";
  String lastname = "";
  String phone1 = "";
  String phone2 = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => userId = prefs.getInt('userId') ?? -1);
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() => firstname = prefs.getString('first_name') ?? "");
      print(firstname);
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() => lastname = prefs.getString('last_name') ?? "");
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() => phone1 = prefs.getString('phone') ?? "");
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() => phone2 = prefs.getString('phone2') ?? "");
    });
  }

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  final secondPhone = TextEditingController();
  String allError = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstName.dispose();
    lastName.dispose();
    phone.dispose();
    secondPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
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
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 130,
                  child: Image(
                    image: Constants.image,
                    // height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: firstName,
                    decoration: InputDecoration(
                        labelText: 'ИМЯ',
                        hintText: firstname,
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 0.0),
                  TextField(
                    controller: lastName,
                    decoration: InputDecoration(
                        labelText: 'ФАМИЛИЯ',
                        hintText: lastname,
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 0.0),
                  TextField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'ТЕЛЕФОН',
                        hintText: phone1,
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    // obscureText: true,
                  ),
                  SizedBox(height: 0.0),
                  TextField(
                    controller: secondPhone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'ДОП. ТЕЛЕФОН',
                        hintText: phone2,
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    // obscureText: true,
                  ),
                  SizedBox(height: 128.0),
                  Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Constants.color,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: FlatButton(
                            onPressed: () async {
                              var dio = new Dio();
                              print(firstName);
                              String url =
                                  "${Constants.baseUrl}api/v1/updateUserInfo/$userId";

                              final Map<String, dynamic> _signUpParameters = {
                                "firstname": firstName.text,
                                "lastname": lastName.text,
                                "phone": phone.text,
                                "phone2": secondPhone.text
                              };

                              final response = await dio.post(url,
                                  data: FormData.fromMap(_signUpParameters));

                              // if (response.data["error"] == "") {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();

                              preferences.setString('first_name',
                                  response.data["dataInfo"]["first_name"]);
                              preferences.setString('last_name',
                                  response.data["dataInfo"]["last_name"]);
                              preferences.setString(
                                  'phone', response.data["dataInfo"]["phone"]);
                              preferences.setString('phone2',
                                  response.data["dataInfo"]["phone2"]);

                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text(
                                'СОХРАНИТЬ ИЗМЕНЕНИЯ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              )),
        ]));
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
