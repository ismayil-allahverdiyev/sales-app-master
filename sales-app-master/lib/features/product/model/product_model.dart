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
  List? image;
  List<String>? images;
  List? favs;

  Product(this.id, this.title, this.price, this.rate, this.images, this.favs,
      this.categorie, this.userId, this.image);

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
    return Product(
      map['id'],
      map['title'],
      double.parse(map['price']),
      map['rate'] != null ? map['rate'] : 0,
      map['images'],
      map['favs'],
      map['category'],
      map['userId'],
      map['image'],
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['title'],
      json['price'],
      json['rate'],
      json['images'],
      json['favs'],
      json['categorie'],
      json['userId'],
      json['image'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
