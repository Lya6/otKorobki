import 'package:template_application/models/categories.dart';

class CategoryViewModel {
  Categories _categories;

  CategoryViewModel({Categories categories}) : _categories = categories;

  String get id {
    return _categories.id;
  }

  String get name {
    return _categories.name;
  }

  String get imagePreview {
    return _categories.imagePreview;
  }
}
