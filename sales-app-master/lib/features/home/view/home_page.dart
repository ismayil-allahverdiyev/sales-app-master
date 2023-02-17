import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/addPage/view/add_page_view.dart';
import 'package:sales_app/features/addVideoPage/view/add_video_view.dart';
import 'package:sales_app/features/category/view/category_view.dart';
import 'package:sales_app/features/home/view/carousel.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';
import 'package:sales_app/features/widgets/custom_bar_app.dart';
import 'package:sales_app/video_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
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
            body: GridView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CategoryView(title: "Paintings")));
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: height / 4,
                            width: width / 2 - 10,
                            child: Card(
                              elevation: 10,
                              color: Color(0xffEDE6E3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "assets/images/bird.png",
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                            child: Container(
                              height: height / 4 - 8,
                              width: width / 2 - 18,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.black,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 16,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Explore ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Icon(
                                    CupertinoIcons.chevron_right_circle,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Paintings",
                        style: GoogleFonts.notoSerif(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: height / 4,
                          width: width / 2 - 10,
                          child: Card(
                            elevation: 10,
                            color: Color(0xffEDE6E3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "assets/images/native_americans.png",
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                          child: Container(
                            height: height / 4 - 8,
                            width: width / 2 - 18,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.black,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 16,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Row(
                              children: [
                                Text(
                                  "Explore ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Icon(
                                  CupertinoIcons.chevron_right_circle,
                                  color: Colors.white,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Paintings",
                      style: GoogleFonts.notoSerif(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: height / 4,
                          width: width / 2 - 10,
                          child: Card(
                            elevation: 10,
                            color: Color(0xffEDE6E3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "assets/images/trees.png",
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                          child: Container(
                            height: height / 4 - 8,
                            width: width / 2 - 18,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.black,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 16,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Row(
                              children: [
                                Text(
                                  "Explore ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Icon(
                                  CupertinoIcons.chevron_right_circle,
                                  color: Colors.white,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Paintings",
                      style: GoogleFonts.notoSerif(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: height / 4,
                          width: width / 2 - 10,
                          child: Card(
                            elevation: 10,
                            color: Color(0xffEDE6E3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "assets/images/whale.png",
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                          child: Container(
                            height: height / 4 - 8,
                            width: width / 2 - 18,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.black,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 16,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Row(
                              children: [
                                Text(
                                  "Explore ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Icon(
                                  CupertinoIcons.chevron_right_circle,
                                  color: Colors.white,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Accessories",
                      style: GoogleFonts.notoSerif(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: height / 4,
                          width: width / 2 - 10,
                          child: Card(
                            elevation: 10,
                            color: Color(0xffEDE6E3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "assets/images/bird.png",
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                          child: Container(
                            height: height / 4 - 8,
                            width: width / 2 - 18,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.black,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 16,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Row(
                              children: [
                                Text(
                                  "Explore ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Icon(
                                  CupertinoIcons.chevron_right_circle,
                                  color: Colors.white,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Paintings",
                      style: GoogleFonts.notoSerif(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
