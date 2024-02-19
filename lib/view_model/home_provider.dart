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

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<String> _loadJsonData() async {
    return await rootBundle.loadString('assets/json/product.json');
  }

  Future<void> fetchData() async {
    // mock data
    // read data from json file and set all to product list
    String jsonData = await _loadJsonData();
    Map<String, dynamic> jsonMap = json.decode(jsonData);
    productList = ProductModel.fromJson(jsonMap);
    _loading = false;
    notifyListeners();
  }

  void setLikeClicked(int id) {
    // find index by product id
    int index = productList!.productItems.indexWhere((item) => item.id == id);
    // set new value (bool) to likeClicked
    productList!.productItems[index].likeClicked = !productList!.productItems[index].likeClicked;

    if (productList!.productItems[index].likeClicked) {
      // if likeClicked == true then add product item to productSelected list
      productSelected.add(productList!.productItems[index]);
    } else {
      // if likeClicked == flalse then remove product item to productSelected list
      productSelected.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }

  void addToCart(ProductItem productItem) {
    // check product id is exist
    // if not exist and product item to productCartList
    if (productCartList.indexWhere((item) => item.id == productItem.id) == -1) {
      productCartList.add(productItem);
    }
    notifyListeners();
  }

  void increaseProduct(int productId) {
    // find index by product id
    int index = productCartList.indexWhere((item) => item.id == productId);
    // set amount of product increase 1
    productCartList[index].amount++;
    notifyListeners();
  }

  void decreseProduct(int productId) {
    // find index by product id
    int index = productCartList.indexWhere((item) => item.id == productId);
    // check the number of products must not be less than 1.
    if (productCartList[index].amount > 1) {
      // set amount of product decrease 1
      productCartList[index].amount--;
    }
    notifyListeners();
  }

  void removeCartProduct(int productId) {
    // remove product item by id
    productCartList.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  double getTotalPrice() {
    // calculate total price sum(price*amount)
    double totalPrice = productCartList.fold(0.0, (previousValue, element) => previousValue + (element.price * element.amount));
    return totalPrice;
  }
}
