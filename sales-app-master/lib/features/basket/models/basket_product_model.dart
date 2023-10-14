import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sales_app/features/search/models/color_model.dart';

class ReloadableProductModel {
  var id;
  String description;
  List<String> image;
  double price;
  List<Color>? colors;

  ReloadableProductModel({
    required this.id,
    required this.description,
    required this.image,
    required this.price,
    required this.colors,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "description": description,
      "image": image,
      "price": price,
      "colorPalette": colors,
    };
  }

  factory ReloadableProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ReloadableProductModel(
      id: map['id'],
      description: map['description'],
      price: double.parse(map['price'].toString()),
      image: List<String>.from(map['image']),
      colors: [
        for (int i = 0; i < map['colorPalette'].length; i++)
          Color(0xFF000000 +
              int.parse(map['colorPalette'][i].substring(1, 7), radix: 16))
      ],
    );
  }

  factory ReloadableProductModel.fromJson(Map<String, dynamic> json) {
    return ReloadableProductModel(
      id: json['id'],
      description: json['description'],
      price: double.parse(json['price']),
      image: json['image'],
      colors: json['colors'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
