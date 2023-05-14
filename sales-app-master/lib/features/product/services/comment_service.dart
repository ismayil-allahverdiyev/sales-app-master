import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sales_app/core/constants/app_constants.dart';

class CommentService {
  getComments(String posterId) async {
    print("posterId " + posterId);
    var response = await http.get(
      Uri.parse(uri + "/comments/getCommentsById?posterId=" + posterId),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );
    return jsonDecode(response.body);
  }

  sendComment({
    required String description,
    required String token,
    required String posterId,
    required String email,
  }) async {
    var response = await http.post(
      Uri.parse(uri + "/comments/addComment"),
      body: jsonEncode(
        {
          "description": description,
          "token": token,
          "email": email,
          "posterId": posterId,
        },
      ),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );
    print("SEEENTT " + response.body);
    return jsonDecode(response.body);
  }
}
