import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCustomSnack({required BuildContext context, required String text}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}