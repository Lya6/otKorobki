import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/main.dart';
import 'package:template_application/screens/choice_region_page.dart';
import 'package:template_application/viewmodels/region/region_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_application/screens/auth_reg_pages/login_page.dart';
import 'user_info_page.dart';
import 'address_page.dart';
import 'orders_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences sharedPreferences;
  SharedPreferences pref;
  String nameCity = "";
  String parentId = "";
  String email = "";
  int userId = -1;

  @override
  void initState() {
    super.initState();

    Provider.of<RegionListViewModel>(context, listen: false).regions();

    // await sharedPreferences.clear();

    // print(pref.containsKey("parentId"));

    SharedPreferences.getInstance().then((prefs) {
      setState(() => nameCity = prefs.getString('nameCity') ?? "");
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() => parentId = prefs.getString('parentId') ?? "");
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() => userId = prefs.getInt('userId') ?? -1);
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() => email = prefs.getString('email') ?? "");
    });

    // print(nameCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Профиль"),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Alert(
                      context: context,
                      title: "Информация",
                      desc: "Версия приложения: 0.9.1",
                      buttons: []).show();
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        children: [
          Image(
            image: Constants.image,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8),
              Text(
                userId == -1 ? "Вы не авторизовались" : email,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          buildAccountOptionRow(context, "Регион: $nameCity", 0),
          if (userId != -1) buildAccountOptionRow(context, "Моя информация", 1),
          if (userId != -1)
            buildAccountOptionRow(context, "Мои адреса доставок", 2),
          if (userId != -1) buildAccountOptionRow(context, "Мои заказы", 3),
          SizedBox(
            height: 40,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (userId != -1) {
            asyncClear();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
              (Route<dynamic> route) => false,
            );
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return LoginPage();
            }));
          }

          // await pref.clear();
          //runApp(MyApp());
        },
        label: userId == -1
            ? Text("       ВОЙТИ В АККАУНТ      ")
            : Text("              Выйти              "),
        backgroundColor: Constants.color,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, int operation) {
    return GestureDetector(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: FlatButton(
        onPressed: () {
          // ignore: missing_return
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            if (operation == 0) return ChoiceRegionPage();
            if (operation == 1) return UserInfoPage();
            if (operation == 2)
              return AddressPage(
                type: "-1",
                ctx: context,
              );
            if (operation == 3) return OrdersPage();
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> asyncClear() async {
    // await pref.remove("parentId");
    pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
