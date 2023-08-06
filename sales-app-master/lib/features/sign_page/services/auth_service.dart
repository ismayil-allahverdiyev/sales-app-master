import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/error_handling.dart';
import 'package:sales_app/core/constants/utils.dart';
import 'package:sales_app/features/home/view/home_page.dart';
import 'package:sales_app/features/sign_page/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../base/view/pages.dart';

class AuthService {
  void signUp(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          type: "",
          token: "");
      print(1);
      print(user.toJson());

      http.Response response = await http.post(Uri.parse("${uri}/api/sign-up"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      print(2);

      print(response.body);

      errorHandler(
          response: response,
          onSuccess: () {
            showCustomSnack(
                text:
                    "Account created! You can login with the same credentials.");
          });

      print(3);
    } catch (e) {
      print("error 1");
      showCustomSnack(text: e.toString());
    }
  }

  void signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      User user = User(
          name: "",
          email: email,
          password: password,
          address: "",
          id: "",
          token: "",
          type: "");

      http.Response response = await http.post(Uri.parse("$uri/api/sign-in"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      print(response.body);
      print(response.body.toString());

      errorHandler(
          response: response,
          onSuccess: () async {
            showCustomSnack(text: "Signed In!");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                "x-auth-token", jsonDecode(response.body)["token"]);
            print(prefs.get("x-auth-token"));
            Provider.of<UserInfoViewModel>(context, listen: false)
                .setUser(response);
            print(Provider.of<UserInfoViewModel>(context, listen: false)
                .toString());
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Pages()),
              (route) => false,
            );
          });
    } catch (e) {
      showCustomSnack(text: e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        prefs.setString("x-auth-token", "");
      }

      var tokenRes = await http.post(Uri.parse("$uri/tokenIsValid"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!
          });

      var response = jsonDecode(tokenRes.body);
      print(token);
      print("running");
      print(response);

      if (response == true) {
        print("response is true");
        http.Response userResponse = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": token
            });

        var userProvider =
            Provider.of<UserInfoViewModel>(context, listen: false);
        userProvider.setUser(userResponse);
        print("token is " +
            Provider.of<UserInfoViewModel>(context, listen: false).user.token +
            " 12 BB");
      }
    } catch (e) {
      showCustomSnack(text: e.toString());
    }
  }
}
