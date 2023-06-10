import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/category/model/category_model.dart';
import 'package:sales_app/features/product/model/product_model.dart';

class SearchService {
  Future<List<Product>> getPostersByCategory(
      {required CategoryModel category}) async {
    var response = await http.post(
      Uri.parse(uri + "/api/getPostersByCategory"),
      body: jsonEncode(category.toMap()),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    List decoded = jsonDecode(response.body);

    List<Product> res = [];

    print("Decoded " + decoded.toString());
    decoded.forEach((element) {
      // print("Element" + Product.fromMap(element).favs.toString());
      res.add(Product.fromMap(element));
    });

    print(res.length);

    return res;
  }
}
