import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/core/constants/utils.dart';

void errorHandler(
    {required http.Response response, required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showCustomSnack(text: jsonDecode(response.body)["message"]);
      break;
    case 500:
      showCustomSnack(text: jsonDecode(response.body)["error"]);
      break;
    default:
      showCustomSnack(text: response.body);
      break;
  }
}
