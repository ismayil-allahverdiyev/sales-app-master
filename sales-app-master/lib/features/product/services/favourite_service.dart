import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_constants.dart';

class FavouriteService {
  addToFavourites({
    required String token,
    required String posterId,
  }) async {
    try {
      var request = await http.post(
        Uri.parse(uri + "/api/addToFavourites"),
        body: jsonEncode({
          "token": token,
          "posterId": posterId,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      return request;
    } catch (e) {
      return e;
    }
  }

  removeFromFavourites({
    required String token,
    required String posterId,
  }) async {
    try {
      var request = await http.post(
        Uri.parse(uri + "/api/removeFromFavourites"),
        body: jsonEncode({
          "token": token,
          "posterId": posterId,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      return request;
    } catch (e) {
      return e;
    }
  }

  getFavourites({
    required String token,
  }) async {
    try {
      var request = await http.get(
        Uri.parse(uri + "/api/getFavourites?token=" + token),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print("getFavourites " + request.body.toString());
      return jsonDecode(request.body);
    } catch (e) {
      print(e);
      return [];
    }
  }

  // /api/favourite/isInTheFavourites

  isInTheFavourites({
    required String token,
    required String posterId,
  }) async {
    try {
      var request = await http.post(
        Uri.parse(uri + "/api/favourite/isInTheFavourites"),
        body: jsonEncode({
          "token": token,
          "posterId": posterId,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (request.statusCode == 200) {
        print("Checkeeer The favourite service finished " + request.body);
        return request;
      }
    } catch (e) {
      return e;
    }
  }
}
