import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../model/user.dart';

class UserInfoViewModel extends ChangeNotifier{

  User _user = User(
    type: "",
    token: "",
    id: "",
    address: "",
    password: "",
    email: "",
    name: ""
  );

  void setUser(Response theUser){
    _user = User(name: jsonDecode(theUser.body)["name"], email: jsonDecode(theUser.body)["email"], password: jsonDecode(theUser.body)["password"], address: jsonDecode(theUser.body)["address"], id: jsonDecode(theUser.body)["_id"], token: jsonDecode(theUser.body)["token"], type: jsonDecode(theUser.body)["type"]);
    notifyListeners();
    print(_user.toJson());
  }

  User get user => _user;
}