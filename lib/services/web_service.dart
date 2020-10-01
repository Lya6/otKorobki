import 'package:dio/dio.dart';
import 'package:template_application/models/categories.dart';
import 'package:template_application/models/goods_order.dart';
import 'package:template_application/models/regions.dart';
import 'package:template_application/models/goods.dart';
import 'package:template_application/models/stores.dart';
import 'package:template_application/models/address.dart';
import 'package:template_application/models/order_list.dart';
import 'package:template_application/models/goods_in_order.dart';
import 'package:template_application/constants.dart';
import 'package:template_application/models/subcategories.dart';

class WebService {
  var dio = new Dio();

  Future<List<Goods>> fetchSeachGoods(
      String symbol, String parentId, int userId) async {
    String url = "${Constants.baseUrl}api/v1/searchListGoods/$parentId/$symbol";

    final Map<String, dynamic> _searchParameters = {"userId": userId};

    final response =
        await dio.post(url, data: FormData.fromMap(_searchParameters));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      print(url);
      return list.map((goods) => Goods.fromJson(goods)).toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<GoodsOrder>> fetchGoodsOrder(int userId, String orderId) async {
    String url =
        "${Constants.baseUrl}api/v1/getListOrderGoods/$userId/$orderId";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((goodsOrder) => GoodsOrder.fromJson(goodsOrder)).toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<GoodsInOrder>> fetchGoodsInOrder(
      int userId, String storeId, String parentId) async {
    String url =
        "${Constants.baseUrl}api/v1/getItemsBasket/$userId/$storeId/$parentId";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      print(list);
      return list
          .map((goodsInOrder) => GoodsInOrder.fromJson(goodsInOrder))
          .toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<Stores>> fetchStores(int userId, String parentId) async {
    String url = "${Constants.baseUrl}api/v1/getListStores/$userId/$parentId";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result["listStore"];
      print(list);
      return list.map((stores) => Stores.fromJson(stores)).toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<OrderList>> fetchOrders(int userId) async {
    String url = "${Constants.baseUrl}api/v1/getOrderList/$userId";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((orders) => OrderList.fromJson(orders)).toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<Address>> fetchAddress(int userId) async {
    String url = "${Constants.baseUrl}api/v1/getDeliveryAddress";

    final Map<String, dynamic> _addressParameters = {"userId": userId};

    final response =
        await dio.post(url, data: FormData.fromMap(_addressParameters));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((address) => Address.fromJson(address)).toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<SubCategories>> fetchSubcategories(
      String idCategory, String parentId, int userId) async {
    String url =
        "${Constants.baseUrl}api/v1/list-category-with-goods/$idCategory/$parentId/$userId";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['listCategory'];
      print(url);
      return list
          .map((subcategories) => SubCategories.fromJson(subcategories))
          .toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<Goods>> fetchGoods(
      String idCategory, String parentId, int userId) async {
    String url =
        "${Constants.baseUrl}api/v1/list-category-with-goods/$idCategory/$parentId/$userId";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['listGoods'];
      print(url);
      return list.map((goods) => Goods.fromJson(goods)).toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<Goods>> fetchNewGoods(String parentId, String userId) async {
    String url = "${Constants.baseUrl}api/v1/list-new-goods/$parentId";

    final Map<String, dynamic> _newGoodsParameters = {
      "urlDomen": Constants.baseUrl,
      "userId": userId
    };

    final response =
        await dio.post(url, data: FormData.fromMap(_newGoodsParameters));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      print(url);
      return list.map((newGoods) => Goods.fromJson(newGoods)).toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<Regions>> fetchRegions() async {
    String url = "${Constants.baseUrl}api/v1/list-region";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['listRegion'];
      print(list);
      return list.map((regions) => Regions.fromJson(regions)).toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }

  Future<List<Categories>> fetchCategories() async {
    String url = "${Constants.baseUrl}api/v1/list-parent-category";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((category) => Categories.fromJson(category)).toList();
    } else {
      throw Exception("Ошибка при получении категорий");
    }
  }
}
