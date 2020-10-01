import 'package:flutter/material.dart';
import 'package:template_application/widgets/category_grid.dart';
import 'package:provider/provider.dart';
import 'package:template_application/viewmodels/category/category_list_view_model.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryListViewModel>(context, listen: false).categories();
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<CategoryListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Выбор категории"),
      ),
      body: CategoryGrid(
        categories: listViewModel.listCategories,
      ),
    );
  }
}
