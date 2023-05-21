import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/utils.dart';

class BasketService {
  addToBasket({
    required String token,
    required String posterId,
  }) async {
    try {
      var request = await http.post(
        Uri.parse(uri + "/api/basket/addToBasket"),
        body: jsonEncode({
          "token": token,
          "posterId": posterId,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print("Checkeeer added " + request.body.toString());

      return request;
    } catch (e) {
      return e;
    }
  }

  removeFromBasket({
    required String token,
    required String posterId,
  }) async {
    try {
      var request = await http.post(
        Uri.parse(uri + "/api/basket/removeFromBasket"),
        body: jsonEncode({
          "token": token,
          "posterId": posterId,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print("Checkeeer removed called " + request.body.toString());

      return request;
    } catch (e) {
      return e;
    }
  }

  isInTheBasket({
    required String token,
    required String posterId,
  }) async {
    try {
      var request = await http.post(
        Uri.parse(uri + "/api/basket/isInTheBasket"),
        body: jsonEncode({
          "token": token,
          "posterId": posterId,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print("Checkeeer The basket service finished " + request.body);
      return request;
    } catch (e) {
      return e;
    }
  }

  getProductsFromBasket({
    required String token,
  }) async {
    try {
      var request = await http.get(
        Uri.parse(uri + "/api/basket/info?token=" + token),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      return jsonDecode(request.body);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
