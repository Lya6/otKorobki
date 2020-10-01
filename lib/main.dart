import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/screens/region_page.dart';
import 'package:template_application/screens/search/search_page.dart';
import 'package:template_application/viewmodels/category/category_list_view_model.dart';
import 'package:template_application/viewmodels/goods_order/goods_order_list_view_model.dart';
import 'package:template_application/viewmodels/new_goods/new_goods_list_view_model.dart';
import 'package:template_application/viewmodels/goods/goods_list_view_model.dart';
import 'package:template_application/screens/main_page/main_page.dart';
import 'package:template_application/screens/category_page/category_page.dart';
import 'package:template_application/screens/cart_page/cart.dart';
import 'package:template_application/screens/profile_page/profile_page.dart';
import 'package:template_application/viewmodels/region/region_list_view_model.dart';
import 'package:template_application/viewmodels/address/address_list_view_model.dart';
import 'package:template_application/viewmodels/order_list/order_list_list_view_model.dart';
import 'package:template_application/viewmodels/search/search_goods_list_view_model.dart';
import 'package:template_application/viewmodels/store/store_list_view_model.dart';
import 'package:template_application/viewmodels/goods_in_order/goods_in_order_list_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_application/viewmodels/subcategories/subcategories_list_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();
  // userId = pref.getInt("userId");

  if (pref.getString('parentId') == null)
    runApp(MyApp());
  else
    runApp(MyAppSecond());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => CategoryListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => NewGoodsListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => GoodsListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => AddressListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => OrderListListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => StoreListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => GoodsInOrderListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => SubcategoriesListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => GoodsOrderListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => SearchGoodsListViewModel(),
      ),
      ChangeNotifierProvider(
          create: (_) => RegionListViewModel(),
          builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: '',
                theme: ThemeData(
                  scaffoldBackgroundColor: Color(0xffFEFDFD),
                  appBarTheme: AppBarTheme(
                    color: Constants.color,
                    elevation: 0,
                    textTheme: TextTheme(),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    actionsIconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                  ),
                ),
                home: RegionPage(),
              ))
      //SharedPreferences pref = await SharedPreferences.getInstance()
    ]);
  }
}

class MyAppSecond extends StatelessWidget {
  // final int userId;

  // MyAppSecond({this.userId});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => CategoryListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => NewGoodsListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => GoodsListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => AddressListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => OrderListListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => StoreListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => GoodsInOrderListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => SubcategoriesListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => GoodsOrderListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => SearchGoodsListViewModel(),
      ),
      ChangeNotifierProvider(
          create: (_) => RegionListViewModel(),
          builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: '',
              theme: ThemeData(
                scaffoldBackgroundColor: Color(0xffFEFDFD),
                appBarTheme: AppBarTheme(
                  color: Constants.color, //Colors.blueGrey,
                  elevation: 0,
                  textTheme: TextTheme(),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  actionsIconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
              ),
              home: Scaffold(
                body: BottomNavigation(),
              )))
      //SharedPreferences pref = await SharedPreferences.getInstance()
    ]);
  }
}

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  int userId;

  @override
  void initState() {
    super.initState();

    funcAsync();
  }

  final List<Widget> _children = [
    MainPage(),
    CategoryPage(),
    CartPage(),
    ProfilePage(),
    SearchPage()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Constants.color,
        items: [
          BottomNavigationBarItem(
            icon: Image(
              color: Constants.color,
              image: AssetImage('images/icons/home.png'),
              height: 25,
            ),
            title: Text('Главная'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              color: Constants.color,
              image: AssetImage('images/icons/catalogue.png'),
              height: 25,
            ),
            title: Text('Категории'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              color: Constants.color,
              image: AssetImage('images/icons/cart.png'),
              height: 25,
            ),
            title: Text('Корзина'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              color: Constants.color,
              image: AssetImage('images/icons/login.png'),
              height: 25,
            ),
            title: Text('Профиль'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Constants.color,
            ),
            title: Text('Поиск'),
          ),
        ],
      ),
    );
  }

  Future<void> funcAsync() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getInt("userId");
  }
}
