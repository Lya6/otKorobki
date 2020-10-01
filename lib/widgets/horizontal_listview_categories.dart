import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/screens/goods_pages/goods_list_page.dart';
import 'package:template_application/viewmodels/category/category_view_model.dart';

class HorizontalListViewCategories extends StatelessWidget {
  final List<CategoryViewModel> categories;

  HorizontalListViewCategories({this.categories});

  @override
  Widget build(BuildContext context) {
    var categories = this.categories;

    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var category in categories)
            Category(
              imageUrl:
                  "${Constants.baseUrl}images/category/${category.imagePreview}",
              imageCaption: category.name,
              categoryId: category.id,
            )
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageUrl;
  final String imageCaption;
  final String categoryId;

  Category({this.imageUrl, this.imageCaption, this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {},
          child: Container(
              width: 145,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GoodsListPage(
                            categoryId: categoryId,
                          )));
                },
                child: ListTile(
                    title: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Constants.color),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset("images/no_logo.png"),
                      height: 80,
                    ),
                    subtitle: Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        imageCaption,
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    )),
              )),
        ));
  }
}
