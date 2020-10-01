import 'package:flutter/material.dart';
import 'package:template_application/widgets/horizontal_listview_categories.dart';
import 'package:template_application/widgets/horizontal_listview_new_goods.dart';
import 'package:template_application/widgets/image_slider_carousel.dart';
import 'package:template_application/viewmodels/category/category_list_view_model.dart';
import 'package:template_application/viewmodels/new_goods/new_goods_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String parentId;
  int userId;
  @override
  void initState() {
    super.initState();

    asyncFunc();
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<CategoryListViewModel>(context);
    var listViewModelNewGoods = Provider.of<NewGoodsListViewModel>(context);

    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Главная",
              ),
              centerTitle: true,
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  ImageSliderCarousel(),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(
                        'Категории',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                  HorizontalListViewCategories(
                      categories: listViewModel.listCategories),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(
                        'Новинки',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                  HorizontalListViewNewGoods(
                    newGoods: listViewModelNewGoods.listNewGoods,
                    userId: userId,
                    regionId: parentId,
                  ),
                ],
              ),
            )));
  }

  Future<void> asyncFunc() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();

    parentId = pref.getString("parentId");
    userId = pref.getInt("userId") ?? -1;

    Provider.of<CategoryListViewModel>(context, listen: false).categories();
    Provider.of<NewGoodsListViewModel>(context, listen: false)
        .newGoods(parentId, userId.toString());
  }
}
