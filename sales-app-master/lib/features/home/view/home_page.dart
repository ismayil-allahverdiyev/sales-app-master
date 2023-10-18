import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/addPage/view/add_page_view.dart';
import 'package:sales_app/features/addVideoPage/view/add_video_view.dart';
import 'package:sales_app/features/category/view/category_view.dart';
import 'package:sales_app/features/home/view/carousel.dart';
import 'package:sales_app/features/home/view/category_view_loading.dart';
import 'package:sales_app/features/home/view/insight.dart';
import 'package:sales_app/features/home/view_model/home_page_view_model.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';
import 'package:sales_app/features/widgets/custom_bar_app.dart';
import 'package:sales_app/video_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);

  CustomAppBar customAppBar = CustomAppBar();
  Object? currentToken;

  void getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.get("x-auth-token") != null
        ? currentToken = prefs.get("x-auth-token")
        : null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    getUserToken();

    return GestureDetector(
      onTap: () => unFocus(context),
      child: Scaffold(
        drawer: SafeArea(
          child: Drawer(
              child: Column(
            children: [
              ListTile(
                title: Text("Add poster"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddPageView()));
                },
              ),
            ],
          )),
        ),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(width * 0.15),
                      bottomRight: Radius.circular(width * 0.15),
                    ),
                  ),
                  expandedHeight: height * 0.8,
                  flexibleSpace: const FlexibleSpaceBar(
                    collapseMode: CollapseMode.none,
                    background: CarouselWidget(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Shop insights",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CupertinoTextField(
                            placeholder: "Search...",
                            prefix: const Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image:
                                    AssetImage("assets/icons/search_home.png"),
                                color: Colors.grey,
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            cursorColor: AppConstants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: Consumer<HomePageViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.listOfCategories.length != 0) {
                  return GridView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (width / 2 - 10) / (width / 3 * 2)),
                    children: viewModel.listOfCategories,
                  );
                } else {
                  return CategoryViewLoading();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
