import 'dart:convert';

class PosterColor {
  String colorName;
  String hexCode;

  PosterColor({
    required this.colorName,
    required this.hexCode,
  });

  Map<String, dynamic> toMap() {
    return {
      "colorName": colorName,
      "hexCode": hexCode,
    };
  }

  factory PosterColor.fromMap(Map<dynamic, dynamic> map) {
    return PosterColor(
      colorName: map['colorName'],
      hexCode: map["hexCode"],
    );
  }

  factory PosterColor.fromJson(Map<String, dynamic> json) {
    return PosterColor(
      colorName: json['colorName'],
      hexCode: json['hexCode'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
