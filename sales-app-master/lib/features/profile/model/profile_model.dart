import 'dart:convert';

ProfileInfo profileInfoFromJson(String str) =>
    ProfileInfo.fromJson(json.decode(str));

String profileInfoToJson(ProfileInfo data) => json.encode(data.toJson());

class ProfileInfo {
  String name;
  String imageUrl;
  String type;

  ProfileInfo({
    required this.name,
    required this.imageUrl,
    required this.type,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => ProfileInfo(
        name: json["name"],
        imageUrl: json["imageUrl"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "type": type,
      };
}
