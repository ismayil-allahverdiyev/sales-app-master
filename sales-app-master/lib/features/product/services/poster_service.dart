import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/core/constants/app_constants.dart';

class PosterService {
  void getAllPosters({
    required BuildContext context,
  }) async {
    print("Try out");
    try {
      print("Try");

      http.Response response = await http
          .get(Uri.parse(uri + "/api/getAllPosters"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      });
      print(response.body);
    } catch (e) {
      print("catch");

      print(e.toString());
    }
  }
}
