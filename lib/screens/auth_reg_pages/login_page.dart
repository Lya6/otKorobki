import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:template_application/main.dart';
import 'package:template_application/services/push_notification_service.dart';
import 'register_page.dart';
import 'package:dio/dio.dart';
import 'package:template_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    password.dispose();
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
                  width: double.infinity,
                  height: 130,
                  child: Image(
                    image: Constants.image,
                    // height: 100,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: 'E-MAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                        labelText: 'ПАРОЛЬ ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    obscureText: true,
                  ),
                  SizedBox(height: 100.0),
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
                              Future<String> future = Future(
                                  () => PushNotificationService().getToken());
                              var dio = new Dio();
                              String url = "${Constants.baseUrl}api/v1/login";

                              final Map<String, dynamic> _loginParameters = {
                                "email": email.text,
                                "password": password.text
                              };

                              final response = await dio.post(url,
                                  data: FormData.fromMap(_loginParameters));

                              if (response.data["error"] == "") {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                print(response.data["data"]);

                                preferences.setInt(
                                    'userId', response.data["data"]["id"]);
                                preferences.setString(
                                    'email', response.data["data"]["email"]);
                                preferences.setString('first_name',
                                    response.data["dataInfo"]["first_name"]);
                                preferences.setString('last_name',
                                    response.data["dataInfo"]["last_name"]);
                                preferences.setString('phone',
                                    response.data["dataInfo"]["phone"]);
                                preferences.setString('phone2',
                                    response.data["dataInfo"]["phone2"]);
                                preferences.setInt('roleId',
                                    response.data["dataInfo"]["role_id"]);
                                preferences.setString('company',
                                    response.data["dataInfo"]["company"]);

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyAppSecond()),
                                  (Route<dynamic> route) => false,
                                );
                              } else
                                showAlertDialog(
                                    context, response.data["error"]);
                            },
                            child: Center(
                              child: Text(
                                'ВОЙТИ',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 20.0),
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
                            onPressed: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return RegisterPage();
                            })),
                            child: Center(
                              child: Text(
                                'РЕГИСТРАЦИЯ',
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
    Alert(context: context, title: "Ошибка", desc: error, buttons: []).show();
  }
}
