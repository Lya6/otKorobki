import 'package:flutter/material.dart';
import 'package:template_application/widgets/search_goods_grid.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String parentId;
  int userId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SearchGoodsGrid(symbol: "хлеб"));
  }
}
