import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/base/view_model/pages_view_model.dart';
import 'package:sales_app/features/basket/view_model/basket_view_model.dart';
import 'package:sales_app/features/home/view/home_page.dart';
import 'package:sales_app/features/profile/view/profile_view.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Provider.of<PagesViewModel>(context).page,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: 50,
                color: Colors.white.withOpacity(0.85),
                child:
                    Consumer<PagesViewModel>(builder: (context, viewModel, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          viewModel.index = 0;
                        },
                        child: Image(
                          image: viewModel.index == 0
                              ? AssetImage(
                                  "assets/icons/homeChosen.png",
                                )
                              : AssetImage("assets/icons/homeNav.png"),
                          color: viewModel.index == 0
                              ? Colors.orange[900]
                              : Colors.grey[600],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.index = 1;
                        },
                        child: Image(
                          image: viewModel.index == 1
                              ? AssetImage(
                                  "assets/icons/searchChosen.png",
                                )
                              : AssetImage("assets/icons/searchNav.png"),
                          color: viewModel.index == 1
                              ? Colors.orange[900]
                              : Colors.grey[600],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<BasketViewModel>(
                            context,
                            listen: false,
                          ).getProducts(
                              token: Provider.of<UserInfoViewModel>(
                                context,
                                listen: false,
                              ).user.token,
                              load: true);
                          viewModel.index = 2;
                        },
                        child: Image(
                          image: viewModel.index == 2
                              ? AssetImage(
                                  "assets/icons/bagChosen.png",
                                )
                              : AssetImage("assets/icons/bagIcon.png"),
                          color: viewModel.index == 2
                              ? Colors.orange[700]
                              : Colors.grey[600],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.index = 3;
                        },
                        child: Image(
                          image: viewModel.index == 3
                              ? AssetImage(
                                  "assets/icons/profileChosen.png",
                                )
                              : AssetImage("assets/icons/profile.png"),
                          color: viewModel.index == 3
                              ? Colors.orange[900]
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        )
      ],
    );
  }
}
