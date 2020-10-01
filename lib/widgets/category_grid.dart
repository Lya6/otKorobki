import 'package:flutter/material.dart';
import 'package:template_application/viewmodels/category/category_view_model.dart';
import 'package:template_application/widgets/image_category.dart';
import 'package:template_application/constants.dart';

import 'package:template_application/screens/goods_pages/goods_list_page.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryViewModel> categories;

  CategoryGrid({this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        var categories = this.categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GoodsListPage(
                      categoryId: categories.id,
                    )));
          },
          child: GridTile(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ImageCategory(
                imageUrl:
                    "${Constants.baseUrl}images/category/${categories.imagePreview}",
              ),
            ),
            footer: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                categories.name,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
      itemCount: this.categories.length,
    );
  }
}
