import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

class ReloadableProductModel {
  var id;
  String description;
  double price;

  ReloadableProductModel({
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

  factory ReloadableProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ReloadableProductModel(
      id: map['id'],
      description: map['description'],
      price: double.parse(map['price']),
    );
  }

  factory ReloadableProductModel.fromJson(Map<String, dynamic> json) {
    return ReloadableProductModel(
      id: json['id'],
      description: json['description'],
      price: double.parse(json['price']),
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
