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

  getProducts({
    required String token,
  }) async {
    var response = await basketService.getProductsFromBasket(token: token);
    List<BasketProductView> list = [];
    response.forEach((element) {
      list.add(BasketProductView(
          basketProduct: BasketProductModel.fromMap(element)));
    });
    _products = list;
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
      if (request.statusCode == 400) {
        // showCustomSnack(
        //   context: context,
        //   text: jsonDecode(request.body)["msg"],
        // );
        return false;
      } else if (request.statusCode == 200 &&
          jsonDecode(request.body)["modifiedCount"] > 0) {
        // showCustomSnack(
        //   context: context,
        //   text: "Poster added to the basket!",
        // );

        return true;
      } else {
        // showCustomSnack(
        //   context: context,
        //   text: "Poster not added to the basket!",
        // );

        return false;
      }
    } catch (e) {
      // showCustomSnack(
      //   context: context,
      //   text: e.toString(),
      // );
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
      print("Checkeeer after remove the basket");

      if (request.statusCode == 400) {
        // showCustomSnack(
        //   context: context,
        //   text: jsonDecode(request.body)["msg"],
        // );
        return false;
      } else if (request.statusCode == 200 &&
          jsonDecode(request.body)["modifiedCount"] > 0) {
        // showCustomSnack(
        //   context: context,
        //   text: "Poster removed from the basket!",
        // );
        return true;
      } else {
        // showCustomSnack(
        //   context: context,
        //   text: "Poster could not be removed from the basket!",
        // );
        return false;
      }
    } catch (e) {
      // showCustomSnack(
      //   context: context,
      //   text: e.toString(),
      // );
      return false;
    }
  }
}
