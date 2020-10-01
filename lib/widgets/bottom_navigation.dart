import 'package:flutter/material.dart';
import 'package:template_application/screens/main_page/main_page.dart';
import 'package:template_application/screens/category_page/category_page.dart';
import 'package:template_application/screens/cart_page/cart.dart';
import 'package:template_application/screens/profile_page/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    ProfilePage()
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
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('images/icons/home.png'),
              height: 20,
            ),
            title: Text('Главная'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('images/icons/catalogue.png'),
              height: 20,
            ),
            title: Text('Категории'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('images/icons/cart.png'),
              height: 20,
            ),
            title: Text('Корзина'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('images/icons/login.png'),
              height: 20,
            ),
            title: Text('Профиль'),
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
