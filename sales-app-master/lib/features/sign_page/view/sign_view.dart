import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import '../view_model/user_info_view_model.dart';

class SignView extends StatelessWidget {
  const SignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentCope = FocusScope.of(context);

        if (!currentCope.hasPrimaryFocus) {
          currentCope.unfocus();
        }
      },
      child: Consumer<UserInfoViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: viewModel.isSignUpOn
                ? Color.fromARGB(255, 235, 160, 76)
                : Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Logo"),
                viewModel.isSignUpOn
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: CustomInputDecoration(
                          hintText: "Name...",
                          iconData: Icons.person,
                          controller: viewModel.nameController,
                        ),
                      )
                    : Container(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: CustomInputDecoration(
                      hintText: "E-mail...",
                      iconData: Icons.mail,
                      controller: viewModel.emailController,
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: CustomInputDecoration(
                    hintText: "Password...",
                    iconData: Icons.key,
                    controller: viewModel.passwordController,
                  ),
                ),
                viewModel.isSignUpOn
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
                        child: CustomInputDecoration(
                          hintText: "Repeat password...",
                          iconData: Icons.key,
                          controller: viewModel.rPasswordController,
                        ),
                      )
                    : Container(),
                const ContinueButton(),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextButton(
                  onPressed: () {
                    viewModel.switchView();
                  },
                  child: Text(
                    viewModel.isSignUpOn ? "Sign in" : "Sign up",
                    style: TextStyle(
                        color: viewModel.isSignUpOn
                            ? Colors.white
                            : AppConstants.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Material CustomInputDecoration({
    required String hintText,
    required TextEditingController controller,
    required IconData iconData,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 5,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent, width: 2),
          ),
          prefixIcon: Icon(iconData),
          hintText: hintText,
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoViewModel>(builder: (context, viewModel, _) {
      return GestureDetector(
        onTap: () {
          if (viewModel.isSignUpOn) {
          } else {
            viewModel.signIn(context: context);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: viewModel.isSignUpOn
                ? Colors.white
                : AppConstants.secondaryColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(48, 12, 48, 12),
            child: Text(
              viewModel.isSignUpOn ? "Sign up" : "Sign in",
              style: TextStyle(
                  color: viewModel.isSignUpOn
                      ? AppConstants.secondaryColor
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1.3),
            ),
          ),
        ),
      );
    });
  }
}
