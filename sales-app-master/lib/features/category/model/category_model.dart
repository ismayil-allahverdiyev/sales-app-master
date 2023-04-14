import 'dart:convert';

class CategoryModel {
  String title;
  String coverUrl;
  int count;

  CategoryModel(
      {required this.title, required this.coverUrl, required this.count});

  String get getTitle => this.title;

  set setTitle(String title) => this.title = title;

  String get getCoverUrl => this.coverUrl;

  set setCoverUrl(String coverUrl) => this.coverUrl = coverUrl;

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      title: map["title"] as String,
      coverUrl: map["coverUrl"] as String,
      count: map["count"] as int,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json["title"],
      coverUrl: json["coverUrl"],
      count: json["count"] as int,
    );
  }

  Map toMap() {
    return {
      "title": getTitle,
      "coverUrl": getCoverUrl,
      "count": count,
    };
  }

  toJson() {
    return jsonEncode(toMap());
  }
}
