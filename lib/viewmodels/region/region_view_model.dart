import 'package:template_application/models/regions.dart';

class RegionViewModel {
  Regions _regions;

  RegionViewModel({Regions regions}) : _regions = regions;

  String get id {
    return _regions.id;
  }

  String get name {
    return _regions.name;
  }
}
