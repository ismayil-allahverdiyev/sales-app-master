import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_constants.dart';

void showCustomSnack({required String text}) {
  snackbarKey.currentState?.showSnackBar(SnackBar(content: Text(text)));
}
