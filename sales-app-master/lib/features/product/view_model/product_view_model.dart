import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_constants.dart';

class ProductViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  List<Image>? _imageWidgets;

  List<Image> get imageWidgets => _imageWidgets!;

  set imageWidgets(List<Image> value) {
    _imageWidgets = value;
  }

  setImageWidgets(List value) {
    List<Image> listOfWidgets = [];
    var logicalScreenSize = window.physicalSize / window.devicePixelRatio;
    var width = logicalScreenSize.width;
    var height = logicalScreenSize.height;
    value.forEach((element) {
      listOfWidgets.add(
        Image.network(
          element,
          fit: BoxFit.cover,
        ),
      );
    });

    imageWidgets = listOfWidgets;
  }

  List<Icon> _rateList = [];

  List<Icon> get rateList => _rateList;

  set rateList(List<Icon> value) {
    _rateList = value;
  }

  ratingSystem(double value) {
    int intOfValue = value.toInt();

    List<Icon> list = [];

    for (int i = 0; i < intOfValue; i++) {
      list.add(Icon(
        Icons.star,
        color: AppConstants.primaryColor,
      ));
    }
    if (value - intOfValue >= 0.5) {
      list.add(
        Icon(
          Icons.star_half,
          color: AppConstants.primaryColor,
        ),
      );
    } else {
      list.length != 5
          ? list.add(
              Icon(
                Icons.star_border,
                color: AppConstants.primaryColor,
              ),
            )
          : list;
    }
    var length = list.length;
    for (int i = 0; i < (5 - length).toInt(); i++) {
      print((0.5).toInt());
      list.add(
        Icon(
          Icons.star_border,
          color: AppConstants.primaryColor,
        ),
      );
    }
    rateList = list;
  }
}
