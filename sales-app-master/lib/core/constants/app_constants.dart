import 'package:flutter/material.dart';

String uri = "https://aisha-sales-app.herokuapp.com";

class AppConstants {
  static const Color primaryColor = Color(0xff762ec1);
  static Color? secondaryColor = Colors.orange[900];
}

unFocus(BuildContext context) {
  FocusScopeNode currentCope = FocusScope.of(context);

  if (!currentCope.hasPrimaryFocus) {
    currentCope.unfocus();
  }
}
