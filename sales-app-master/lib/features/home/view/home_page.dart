import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/addPage/view/add_page_view.dart';
import 'package:sales_app/features/addVideoPage/view/add_video_view.dart';
import 'package:sales_app/features/category/view/category_view.dart';
import 'package:sales_app/features/home/view/carousel.dart';
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
                  expandedHeight: 420,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.none,
                    background: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: CarouselWidget(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                    child: Text(
                      "Shop insights",
                      style: GoogleFonts.notoSerif(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ];
            },
            body: Consumer<HomePageViewModel>(
              builder: (context, viewModel, child) {
                print("Viewmodel called " +
                    viewModel.listOfCategories.length.toString());
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
