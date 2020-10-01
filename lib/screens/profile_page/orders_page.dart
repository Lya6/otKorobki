import 'package:flutter/material.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/widgets/orders_grid.dart';
import 'package:provider/provider.dart';
import 'package:template_application/viewmodels/order_list/order_list_list_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String parentId;
  int userId;
  @override
  void initState() {
    super.initState();
    funcAsync();
    print(parentId);
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<OrderListListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.color,
        elevation: 1,
        centerTitle: true,
        title: Text("Мои заказы"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: OrdersGrid(
        orders: listViewModel.listOrders,
        userId: userId,
      ),
    );
  }

  Future<void> funcAsync() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();

    parentId = pref.getString("parentId");
    userId = pref.getInt("userId") ?? -1;

    Provider.of<OrderListListViewModel>(context, listen: false).orders(userId);
  }
}
