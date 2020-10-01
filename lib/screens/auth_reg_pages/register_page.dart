import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import 'package:template_application/main.dart';
import 'package:template_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  String allError = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstName.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool checkedValue = false;
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
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 128,
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
                padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: firstName,
                      decoration: InputDecoration(
                          labelText: 'ИМЯ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 0.0),
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
                    SizedBox(height: 0.0),
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
                    SizedBox(height: 30.0),
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: RoundCheckBox(
                              onTap: (selected) {
                                checkedValue = !checkedValue;
                                print(checkedValue.toString());
                              },
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: FlatButton(
                                  onPressed: () => checkedValue =
                                      checkedValue == false ? true : false,
                                  child: Text(
                                      "Согласен на обработку \nперсональных данных")))
                        ]),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       labelText: 'ПОВТОРИТЕ ПАРОЛЬ ',
                    //       labelStyle: TextStyle(
                    //           fontFamily: 'Montserrat',
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black),
                    //       focusedBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.red))),
                    //   obscureText: true,
                    // ),
                    // SizedBox(height: 100.0),
                    // Center(
                    //     child: Container(
                    //   height: 40.0,
                    //   child: Material(
                    //       borderRadius: BorderRadius.circular(20.0),
                    //       shadowColor: Colors.greenAccent,
                    //       color: Color(0xFF00b3b3),
                    //       elevation: 7.0,
                    //       child: GestureDetector(
                    //         onTap: () {},
                    //         child: FlatButton(
                    //           onPressed: () async {
                    //             if (checkedValue == true) {
                    //               var dio = new Dio();
                    //               String url = "${Constants.baseUrl}api/v1/signup";

                    //               final Map<String, dynamic> _signUpParameters = {
                    //                 "firstname": firstName.text,
                    //                 "email": email.text,
                    //                 "phone": "00",
                    //                 "password": password.text
                    //               };

                    //               final response = await dio.post(url,
                    //                   data: FormData.fromMap(_signUpParameters));

                    //               if (response.data["error"] == "") {
                    //                 SharedPreferences preferences =
                    //                     await SharedPreferences.getInstance();

                    //                 preferences.setInt(
                    //                     'userId', response.data["data"]["id"]);
                    //                 preferences.setString(
                    //                     'email', response.data["data"]["email"]);
                    //                 preferences.setString('first_name',
                    //                     response.data["dataInfo"]["first_name"]);
                    //                 preferences.setString('last_name',
                    //                     response.data["dataInfo"]["last_name"]);
                    //                 preferences.setString('phone',
                    //                     response.data["dataInfo"]["phone"]);
                    //                 preferences.setString('phone2',
                    //                     response.data["dataInfo"]["phone2"]);
                    //                 preferences.setInt('roleId',
                    //                     response.data["dataInfo"]["role_id"]);
                    //                 preferences.setString('company',
                    //                     response.data["dataInfo"]["company"]);

                    //                 Navigator.pushAndRemoveUntil(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => MyAppSecond()),
                    //                   (Route<dynamic> route) => false,
                    //                 );
                    //               } else {
                    //                 if (response.data["error"]["firstname"] !=
                    //                     null) {
                    //                   allError +=
                    //                       "\n${response.data["error"]["firstname"][0]}";
                    //                 }
                    //                 if (response.data["error"]["email"] != null) {
                    //                   allError +=
                    //                       "\n${response.data["error"]["email"][0]}";
                    //                 }
                    //                 if (response.data["error"]["password"] !=
                    //                     null) {
                    //                   allError +=
                    //                       "\n${response.data["error"]["password"][0]}";
                    //                 }
                    //                 showAlertDialog(context, allError);
                    //                 allError = "";
                    //               }
                    //             } else {
                    //               Flushbar(
                    //                 message:
                    //                     "Необходимо дать согласие на обработку персональных данных!",
                    //                 duration: Duration(seconds: 3),
                    //               ).show(context);
                    //             }
                    //           },
                    //           child: Center(
                    //             child: Text(
                    //               'Зарегистрироваться',
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontFamily: 'Montserrat'),
                    //             ),
                    //           ),
                    //         ),
                    //       )),
                    // ))
                  ],
                )),
            // SizedBox(height: 15.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //       'New to Spotify?',
            //       style: TextStyle(
            //         fontFamily: 'Montserrat',
            //       ),
            //     ),
            //     SizedBox(width: 5.0),
            //     InkWell(
            //       child: Text('Register',
            //           style: TextStyle(
            //               color: Colors.green,
            //               fontFamily: 'Montserrat',
            //               fontWeight: FontWeight.bold,
            //               decoration: TextDecoration.underline)),
            //     )
            //   ],
            // )
          ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (checkedValue == true) {
            var dio = new Dio();
            String url = "${Constants.baseUrl}api/v1/signup";

            final Map<String, dynamic> _signUpParameters = {
              "firstname": firstName.text,
              "email": email.text,
              "phone": "00",
              "password": password.text
            };

            final response =
                await dio.post(url, data: FormData.fromMap(_signUpParameters));

            if (response.data["error"] == "") {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();

              preferences.setInt('userId', response.data["data"]["id"]);
              preferences.setString('email', response.data["data"]["email"]);
              preferences.setString(
                  'first_name', response.data["dataInfo"]["first_name"]);
              preferences.setString(
                  'last_name', response.data["dataInfo"]["last_name"]);
              preferences.setString(
                  'phone', response.data["dataInfo"]["phone"]);
              preferences.setString(
                  'phone2', response.data["dataInfo"]["phone2"]);
              preferences.setInt(
                  'roleId', response.data["dataInfo"]["role_id"]);
              preferences.setString(
                  'company', response.data["dataInfo"]["company"]);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyAppSecond()),
                (Route<dynamic> route) => false,
              );
            } else {
              if (response.data["error"]["firstname"] != null) {
                allError += "\n${response.data["error"]["firstname"][0]}";
              }
              if (response.data["error"]["email"] != null) {
                allError += "\n${response.data["error"]["email"][0]}";
              }
              if (response.data["error"]["password"] != null) {
                allError += "\n${response.data["error"]["password"][0]}";
              }
              showAlertDialog(context, allError);
              allError = "";
            }
          } else {
            Flushbar(
              message:
                  "Необходимо дать согласие на обработку персональных данных!",
              duration: Duration(seconds: 3),
            ).show(context);
          }
        },
        label: Text("       ЗАРЕГИСТРИРОВАТЬСЯ       "),
        backgroundColor: Constants.color,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  showAlertDialog(BuildContext context, String error) {
    Alert(context: context, title: "Ошибка", desc: error, buttons: []).show();
  }
}
