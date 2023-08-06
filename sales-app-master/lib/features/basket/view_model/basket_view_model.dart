import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/basket/services/basket_service.dart';
import 'package:sales_app/features/basket/view/basket_product_view.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/view_model/product_view_model.dart';

import '../../../core/constants/utils.dart';
import '../models/basket_product_model.dart';

class BasketViewModel extends ChangeNotifier {
  BasketService basketService = BasketService();

  List<BasketProductView> _products = [];
  List<BasketProductView> get products => _products;
  set products(List<BasketProductView> value) {
    _products = value;
  }

  bool _productsLoading = false;
  bool get productsLoading => this._productsLoading;
  set productsLoading(bool value) => this._productsLoading = value;

  getProducts({
    required String token,
    required bool load,
  }) async {
    productsLoading = true;
    if (load) {
      notifyListeners();
    }
    var response = await basketService.getProductsFromBasket(token: token);
    List<BasketProductView> list = [];
    response.forEach((element) {
      list.add(BasketProductView(
          reloadableProduct: ReloadableProductModel.fromMap(element)));
    });
    _products = list;
    productsLoading = false;
    if (load) {
      notifyListeners();
    }
  }

  addProductToTheBasket({
    required BuildContext context,
    required String posterId,
    required String token,
  }) async {
    try {
      var request =
          await basketService.addToBasket(token: token, posterId: posterId);
      print("Checkeeer after addto the basket");
      if (request.statusCode == 404) {
        showCustomSnack(
          text: jsonDecode(request.body)["msg"],
        );
        return false;
      } else if (request.statusCode == 200 &&
          jsonDecode(request.body)["modifiedCount"] > 0) {
        showCustomSnack(
          text: "Poster added to the basket!",
        );

        return true;
      } else {
        showCustomSnack(
          text: "Poster not added to the basket!",
        );

        return false;
      }
    } catch (e) {
      showCustomSnack(
        text: e.toString(),
      );
      Provider.of<ProductViewModel>(context, listen: false).checkingTheBasket;

      return false;
    }
  }

  removeProductFromBasket({
    required BuildContext context,
    required String posterId,
    required String token,
  }) async {
    try {
      var request = await basketService.removeFromBasket(
          token: token, posterId: posterId);

      if (request.statusCode == 404) {
        return false;
      } else if (request.statusCode == 200 &&
          jsonDecode(request.body)["modifiedCount"] > 0) {
        getProducts(token: token, load: true);

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  emptyTheBasket({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var request = await basketService.emptyBasket(token: token);

      if (request.statusCode == 404) {
        return false;
      } else if (request.statusCode == 200 &&
          jsonDecode(request.body)["modifiedCount"] > 0) {
        getProducts(token: token, load: true);

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
