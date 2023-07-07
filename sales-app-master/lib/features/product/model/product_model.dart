import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

class Product {
  var id;
  get getId => this.id;
  set setId(var id) => this.id = id;

  String userId;
  get getUserId => this.userId;
  set setUserId(userId) => this.userId = userId;

  String categorie;
  get getCategorie => this.categorie;
  set setCategorie(categorie) => this.categorie = categorie;

  String title;
  get getTitle => this.title;
  set setTitle(title) => this.title = title;

  double price;
  get getPrice => this.price;
  set setPrice(price) => this.price = price;

  double rate;
  get getRate => this.rate;
  set setRate(rate) => this.rate = rate;

  List<dynamic>? images;
  get getImages => this.images;
  set setImages(images) => this.images = images;

  List? favs;
  get getFavs => this.favs;
  set setFavs(favs) => this.favs = favs;

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
    return Product(
      id: map['_id'] != null
          ? map['_id']
          : map['id'] != null
              ? map['id']
              : "",
      title: map['title'],
      price: double.parse(map['price']),
      rate: map['rate'] != null ? map['rate'] : 0,
      images: map['image'] is List ? map['image'] : [map['image']],
      favs: map['favs'],
      categorie: map['category'] is List ? map['category'] : "",
      userId: map['userId'] is List ? map['userId'] : "",
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      price: double.parse(json['price']),
      rate: json['rate'] != null ? json['rate'] : 0,
      images: json['image'] is List ? json['image'] : [json['image']],
      favs: json['favs'],
      categorie: json['category'] is List ? json['category'] : "",
      userId: json['userId'] is List ? json['userId'] : "",
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
