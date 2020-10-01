import 'package:template_application/models/subcategories.dart';

class SubcategoriesViewModel {
  SubCategories _subCategories;

  SubcategoriesViewModel({SubCategories subCategories})
      : _subCategories = subCategories;

  String get id {
    return _subCategories.id;
  }

  String get name {
    return _subCategories.name;
  }
}
