import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import '../model/product_model.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  bool _loading = true;
  bool get loading => _loading;
  ProductModel? productList;
  List<ProductItem> productSelected = [];
  List<ProductItem> productCartList = [];

  //int countProductItem = 0;

  onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<String> _loadJsonData() async {
    return await rootBundle.loadString('assets/json/product.json');
  }

  Future<void> fetchData() async {
    String jsonData = await _loadJsonData();
    Map<String, dynamic> jsonMap = json.decode(jsonData);
    productList = ProductModel.fromJson(jsonMap);
    _loading = false;
    notifyListeners();
  }

  void setLikeClicked(int id) {
    int index = productList!.productItems.indexWhere((item) => item.id == id);
    productList!.productItems[index].likeClicked = !productList!.productItems[index].likeClicked;

    if (productList!.productItems[index].likeClicked) {
      productSelected.add(productList!.productItems[index]);
    } else {
      productSelected.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }

  void addToCart(ProductItem productItem) {
    productCartList.add(productItem);
    notifyListeners();
  }

  increaseProduct(int productId) {
    int index = productCartList.indexWhere((item) => item.id == productId);
    productCartList[index].amount++;
    notifyListeners();
  }

  decreseProduct(int productId) {
    int index = productCartList.indexWhere((item) => item.id == productId);
    if (productCartList[index].amount > 1) {
      productCartList[index].amount--;
    }
    notifyListeners();
  }

  removeCartProduct(int productId) {
    productCartList.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  double getTotalPrice() {
    double totalPrice = productCartList.fold(0.0, (previousValue, element) => previousValue + (element.price * element.amount));
    return totalPrice;
  }
}
