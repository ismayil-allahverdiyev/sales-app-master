import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/core/constants/utils.dart';

void errorHandler({
    required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess
  }){
  switch(response.statusCode){
    case 200:
      onSuccess();
      break;
    case 400:
      showCustomSnack(context: context, text:jsonDecode(response.body)["message"]);
      break;
    case 500:
      showCustomSnack(context: context, text:jsonDecode(response.body)["error"]);
      break;
    default:
      showCustomSnack(context: context, text:response.body);
      break;
  }
}