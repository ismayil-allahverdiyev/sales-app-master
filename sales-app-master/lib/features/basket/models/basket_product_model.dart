import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

class BasketProductModel {
  var id;
  String description;
  double price;

  BasketProductModel({
    required this.id,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "description": description,
      "price": price,
    };
  }

  factory BasketProductModel.fromMap(Map<dynamic, dynamic> map) {
    return BasketProductModel(
      id: map['id'],
      description: map['description'],
      price: double.parse(map['price']),
    );
  }

  factory BasketProductModel.fromJson(Map<String, dynamic> json) {
    return BasketProductModel(
      id: json['id'],
      description: json['description'],
      price: double.parse(json['price']),
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
