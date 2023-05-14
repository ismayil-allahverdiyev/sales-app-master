import 'dart:convert';

class Comment {
  String id;
  String userId;
  String posterId;
  String imageUrl;
  String date;
  String description;
  String username;

  Comment({
    required this.id,
    required this.userId,
    required this.posterId,
    required this.date,
    required this.description,
    required this.username,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "posterId": posterId,
      "date": date,
      "description": description,
      "username": username,
      "imageUrl": imageUrl,
    };
  }

  factory Comment.fromMap(Map<dynamic, dynamic> map) {
    return Comment(
      id: map['_id'],
      userId: map['userId'],
      posterId: map['posterId'],
      date: map['date'],
      description: map['description'],
      username: map["username"],
      imageUrl: map['imageUrl'] == null ? "" : map['imageUrl'],
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      posterId: json['posterId'],
      date: json['date'],
      description: json['description'],
      username: json['username'],
      imageUrl: json['imageUrl'] == null ? "" : json['imageUrl'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
