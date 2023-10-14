import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_constants.dart';

class ProfileService {
  getProfileInfo({
    required String token,
  }) async {
    try {
      var request = await http.get(
        Uri.parse("$uri/api/profile/getProfileInfo?token=$token"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      return jsonDecode(request.body);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
