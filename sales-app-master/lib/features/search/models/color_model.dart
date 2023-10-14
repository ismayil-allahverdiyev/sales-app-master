// To parse this JSON data, do
//
//     final colorModel = colorModelFromJson(jsonString);

import 'dart:convert';

List<ColorModel> colorModelFromJson(String str) =>
    List<ColorModel>.from(json.decode(str).map((x) => ColorModel.fromJson(x)));

String colorModelToJson(List<ColorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ColorModel {
  String id;
  String colorName;
  List<String> hexCodes;
  int v;

  ColorModel({
    required this.id,
    required this.colorName,
    required this.hexCodes,
    required this.v,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        id: json["_id"],
        colorName: json["colorName"],
        hexCodes: List<String>.from(json["hexCodes"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "colorName": colorName,
        "hexCodes": List<dynamic>.from(hexCodes.map((x) => x)),
        "__v": v,
      };
}
