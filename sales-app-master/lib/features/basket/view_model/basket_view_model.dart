import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/features/basket/view/basket_product_view.dart';
import 'package:sales_app/features/product/model/product_model.dart';

class BasketViewModel extends ChangeNotifier {
  List<BasketProductView> _products = [];

  List<BasketProductView> get products => _products;

  set products(List<BasketProductView> value) {
    _products = value;
  }

  getProducts() async {
    await Future.delayed(Duration(seconds: 5));
    print("waited");
    List<BasketProductView> list = [];
    List<Product> products = [
      Product(
          0,
          "Some mountain view that you would never see in your entire life habibi",
          15,
          4.8,
          ["assets/images/whale.png", "assets/images/trees.png"],
          [],
          "",
          0),
      Product(
          1,
          "Some mountain view that you would never see in your entire life habibi",
          23,
          2.3,
          [
            "assets/images/trees.png",
            "assets/images/whale.png",
            "assets/images/bird.png"
          ],
          [],
          "",
          0),
      Product(
          2,
          "Some mountain view that you would never see in your entire life habibi",
          8,
          3.5,
          ["assets/images/native_americans.png"],
          [],
          "",
          0),
      Product(
          3,
          "Some mountain view that you would never see in your entire life habibi",
          37,
          4.0,
          ["assets/images/bird.png"],
          [],
          "",
          0),
    ];
    products.forEach((element) {
      list.add(BasketProductView(product: element));
    });
    _products = list;
  }
}
