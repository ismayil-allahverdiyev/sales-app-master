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
        id: 1,
        title: "aaaaaaa",
        price: 23,
        rate: 3.7,
        images: ["assets/images/native_americans.png"],
        favs: [],
        categorie: "",
        userId: "",
      ),
      Product(
        id: 1,
        title: "aaaaaaa",
        price: 23,
        rate: 3.7,
        images: ["assets/images/native_americans.png"],
        favs: [],
        categorie: "",
        userId: "",
      ),
      Product(
        id: 1,
        title: "aaaaaaa",
        price: 23,
        rate: 3.7,
        images: ["assets/images/native_americans.png"],
        favs: [],
        categorie: "",
        userId: "",
      ),
    ];
    products.forEach((element) {
      list.add(BasketProductView(product: element));
    });
    _products = list;
  }
}
