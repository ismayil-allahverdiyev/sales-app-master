import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/sign_page/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_model/user_info_view_model.dart';

class SignView extends StatefulWidget {
  const SignView({Key? key}) : super(key: key);

  @override
  State<SignView> createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  AuthService authService = AuthService();
  Object? currentToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserToken();
    print(currentToken);
  }

  void getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.get("x-auth-token") != null
        ? currentToken = prefs.get("x-auth-token")
        : null;
    print("currentToken is" + currentToken.toString());
  }

  void signUp() {
    authService.signUp(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        name: "name");
  }

  void signIn() {
    authService.signIn(
        context: context,
        email: emailController.text,
        password: passwordController.text);
    getUserToken();
  }

  @override
  Widget build(BuildContext context) {
    getUserToken();
    print(Provider.of<UserInfoViewModel>(context, listen: false).toString());

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentCope = FocusScope.of(context);

        if (!currentCope.hasPrimaryFocus) {
          currentCope.unfocus();
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Logo"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: AppConstants.primaryColor, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: AppConstants.primaryColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: AppConstants.primaryColor, width: 2),
                    ),
                    prefixIcon: Icon(Icons.person),
                    hintText: "E-mail..."),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: AppConstants.primaryColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: AppConstants.primaryColor, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: AppConstants.primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(CupertinoIcons.eye_fill),
                    onPressed: () {},
                  ),
                  hintText: "Password...",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                signIn();
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xfff4bb39),
                    Color(0xfff47748),
                    Color(0xfff63958),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(48, 12, 48, 12),
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1.3),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                  color: AppConstants.secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
