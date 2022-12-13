import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/base/view_model/base_view_model.dart';
import 'package:sales_app/features/basket/view/basket_view.dart';
import 'package:sales_app/features/home/view/home_page.dart';
import 'package:sales_app/features/profile/view/profile_view.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        PageView(
          controller: Provider.of<BaseViewModel>(context, listen: false).pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePageView(),
            BasketView(),
            ProfileView()
          ],
        ),
        Positioned(
          left: 10,
          right: 10,
          bottom: 10,
          child: Stack(
            children: [
              Container(
                height: 50,
                width: width-20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppConstants.primaryColor,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 2,
                      color: Colors.white,
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Consumer<BaseViewModel>(
                builder: (context, baseViewModel, child) {
                  return Positioned(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            baseViewModel.currentIndex = 0;
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: baseViewModel.currentIndex == 0 ? (width-24-90)/6-2 : (width-24 - 90)/6+3,
                              ),
                              SizedBox(
                                width: baseViewModel.currentIndex == 0 ? 34 : 24,
                                height: 50,
                                child: FittedBox(
                                  child: Icon(CupertinoIcons.house, color: baseViewModel.currentIndex == 0 ? AppConstants.secondaryColor : Colors.white,),
                                ),
                              ),
                              SizedBox(
                                width: baseViewModel.currentIndex == 0 ? (width-24-90)/6 : (width-24 - 90)/6+5,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            baseViewModel.currentIndex = 1;
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: baseViewModel.currentIndex == 1 ? (width-24-90)/6-2 : (width-24 - 90)/6+3,
                              ),
                              SizedBox(
                                width: baseViewModel.currentIndex == 1 ? 34 : 24,
                                height: 50,
                                child: FittedBox(
                                  child: Icon(Icons.shopping_basket_outlined, color: baseViewModel.currentIndex == 1 ? AppConstants.secondaryColor : Colors.white,),
                                ),
                              ),
                              SizedBox(
                                width: baseViewModel.currentIndex == 1 ? (width-24-90)/6 : (width-24 - 90)/6+5,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            baseViewModel.currentIndex = 2;
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: baseViewModel.currentIndex == 2 ? (width-24-90)/6-2 : (width-24 - 90)/6+3,
                              ),
                              SizedBox(
                                width: baseViewModel.currentIndex == 2 ? 34 : 24,
                                height: 50,
                                child: FittedBox(
                                  child: Icon(Icons.account_circle_outlined, color: baseViewModel.currentIndex == 2 ? AppConstants.secondaryColor : Colors.white,),
                                ),
                              ),
                              SizedBox(
                                width: baseViewModel.currentIndex == 2 ? (width-24-90)/6-2 : (width-24 - 90)/6+3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              )
            ],
          ),
        )
      ],
    );
  }
}
