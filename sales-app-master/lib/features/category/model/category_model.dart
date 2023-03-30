import 'dart:convert';

class CategoryModel {
  String title;
  String coverUrl;

  CategoryModel({required this.title, required this.coverUrl});

  String get getTitle => this.title;

  set setTitle(String title) => this.title = title;

  get getCoverUrl => this.coverUrl;

  set setCoverUrl(coverUrl) => this.coverUrl = coverUrl;

  Map<String, String> toMap() {
    return {
      "title": title,
      "coverUrl": coverUrl,
    };
  }

  toJson() {
    return jsonEncode(toMap());
  }
}
