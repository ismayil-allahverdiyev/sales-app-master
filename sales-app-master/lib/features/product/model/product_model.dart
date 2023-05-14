import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

class Product {
  var id;
  String userId;
  String categorie;
  String title;
  double price;
  double rate;
  List<dynamic>? images;
  List? favs;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.rate,
      this.images,
      required this.favs,
      required this.categorie,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "category": categorie,
      "userId": userId,
      "title": title,
      "price": price,
      "rate": rate,
      "images": images,
      "favs": favs,
    };
  }

  factory Product.fromMap(Map<dynamic, dynamic> map) {
    print("fromMap " + map['image'][0].toString());
    return Product(
      id: map['_id'],
      title: map['title'],
      price: double.parse(map['price']),
      rate: map['rate'] != null ? map['rate'] : 0,
      images: map['image'],
      favs: map['favs'],
      categorie: map['category'],
      userId: map['userId'],
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      price: double.parse(json['price']),
      rate: json['rate'] != null ? json['rate'] : 0,
      images: json['images'],
      favs: json['favs'],
      categorie: json['category'],
      userId: json['userId'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
