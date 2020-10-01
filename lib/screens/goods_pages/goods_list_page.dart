import 'package:flutter/material.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/viewmodels/subcategories/subcategories_list_view_model.dart';
import 'package:template_application/widgets/goods_grid.dart';
import 'package:provider/provider.dart';
import 'package:template_application/viewmodels/goods/goods_list_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_application/viewmodels/category/category_list_view_model.dart';

class GoodsListPage extends StatefulWidget {
  final String categoryId;

  GoodsListPage({this.categoryId});

  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage> {
  String parentId;
  int userId;
  @override
  void initState() {
    super.initState();

    // SharedPreferences.getInstance().then((prefs) {
    //   setState(() => userId = prefs.getInt('userId') ?? -1);
    // });
    // SharedPreferences.getInstance().then((prefs) {
    //   setState(() => parentId = prefs.getString('parentId') ?? "");
    // });
    funcAsync();
    print(parentId);
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<SubcategoriesListViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.color,
          elevation: 1,
          centerTitle: true,
          title: Text("Товары"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: GoodsGrid(
          // goods: listViewModel.lis,
          // userId: userId,
          // region: parentId,
          subcategories: listViewModel.listSubcategories,
          categoryId: widget.categoryId,
        ));
  }

  Future<void> funcAsync() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();

    parentId = pref.getString("parentId");
    userId = pref.getInt("userId") ?? -1;

    Provider.of<CategoryListViewModel>(context, listen: false).categories();
    Provider.of<GoodsListViewModel>(context, listen: false)
        .goods(widget.categoryId, parentId, userId);
    Provider.of<SubcategoriesListViewModel>(context, listen: false)
        .subcategories(widget.categoryId, parentId, userId);
  }
}
