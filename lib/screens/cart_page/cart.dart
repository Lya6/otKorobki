import 'dart:async';
import 'package:flutter/material.dart';
import 'package:template_application/screens/auth_reg_pages/login_page.dart';
import 'package:template_application/screens/cart_page/select_payment_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:template_application/viewmodels/store/store_list_view_model.dart';
import 'package:template_application/constants.dart';
import 'package:dio/dio.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  SharedPreferences sharedPreferences;
  int userId = -1;
  String parentId = "";
  @override
  void initState() {
    super.initState();

    asyncFunc();

    SharedPreferences.getInstance().then((prefs) {
      setState(() => userId = prefs.getInt('userId') ?? -1);
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() => parentId = prefs.getString('parentId') ?? "-1");
    });
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<StoreListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Выбор поставщика"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: listViewModel.listStores.length >= 1
            ? ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: listViewModel.listStores.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(listViewModel.listStores[index].storeName),
                      onTap: () async {
                        var dio = new Dio();

                        String url =
                            "${Constants.baseUrl}api/v1/getMinAmountDelivery/${listViewModel.listStores[index].storeId}/$parentId";

                        final response = await dio.get(url);
                        print(response.data["minSumPickup"]);
                        // minSumPickup = response.data["minSumPickup"];
                        // minSumDelivery = response.data["minSumDelivery"];
                        return Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return SelectPaymentTypePage(
                            storeId: listViewModel.listStores[index].storeId,
                            userId: userId,
                            parentId: parentId,
                            storeAddressPickup: listViewModel
                                .listStores[index].storeAddressPickup,
                            minSumDelivery: response.data["minSumDelivery"],
                            minSumPickup: response.data["minSumPickup"],
                          );
                        }));
                      });
                })
            : Text(
                userId == -1
                    ? "Для просмотра корзины нужно авторизоваться"
                    : "В корзине пока ничего нет",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
      ),
      floatingActionButton: Visibility(
        visible: userId == -1 ? true : false,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return LoginPage();
            }));
          },
          label: Text("       ВОЙТИ В АККАУНТ      "),
          backgroundColor: Constants.color,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> asyncFunc() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getInt("userId") ?? -1;
    parentId = pref.getString("parentId") ?? "";
    Provider.of<StoreListViewModel>(context, listen: false)
        .stores(userId, parentId);
  }

  Future<void> asyncFuncSecond() async {
    if (Provider.of<StoreListViewModel>(context).listStores.length == 1)
      print("1");
  }
}
