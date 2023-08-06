import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../services/auth_service.dart';

class UserInfoViewModel extends ChangeNotifier {
  UserInfoViewModel() {
    getUserToken();
  }

  User _user = User(
      type: "",
      token: "",
      id: "",
      address: "",
      password: "",
      email: "",
      name: "");

  void setUser(Response theUser) {
    _user = User(
        name: jsonDecode(theUser.body)["name"],
        email: jsonDecode(theUser.body)["email"],
        password: jsonDecode(theUser.body)["password"],
        address: jsonDecode(theUser.body)["address"],
        id: jsonDecode(theUser.body)["_id"],
        token: jsonDecode(theUser.body)["token"],
        type: jsonDecode(theUser.body)["type"]);
    notifyListeners();
    print(_user.toJson());
  }

  User get user => _user;

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var rPasswordController = TextEditingController();
  AuthService authService = AuthService();
  Object? currentToken;
  bool isSignUpOn = false;

  void switchView() {
    isSignUpOn = !isSignUpOn;
    notifyListeners();
  }

  void getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.get("x-auth-token") != null
        ? currentToken = prefs.get("x-auth-token")
        : null;
    print("currentToken is" + currentToken.toString());
  }

  void signUp({required BuildContext context}) {
    authService.signUp(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        name: "name");
  }

  void signIn({required BuildContext context}) {
    authService.signIn(
        context: context,
        email: emailController.text,
        password: passwordController.text);
    getUserToken();
  }

  void signOut() async {
    _user = User(
      type: "",
      token: "",
      id: "",
      address: "",
      password: "",
      email: "",
      name: "",
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentToken = null;
    prefs.setString("x-auth-token", "");
  }
}
