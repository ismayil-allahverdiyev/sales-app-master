import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/category/view/category_product_view.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/view/product_view.dart';

import '../view_model/profile_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).tabController =
        TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: width * 0.6,
              backgroundColor: Colors.white,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: width * 0.05,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: width * 0.2 + 4,
                              backgroundColor: AppConstants.primaryColor,
                            ),
                            CircleAvatar(
                              radius: width * 0.2 + 2,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: width * 0.2,
                              backgroundColor: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width * 0.05,
                        ),
                        Text(
                          "User Userov",
                          style: TextStyle(fontSize: height * 0.02),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                          child: IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: AppConstants.primaryColor,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width / 5 * 4,
                                          // height: width / 7 * 2 + 32,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: width / 7,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey[300]!,
                                                      style: BorderStyle.solid,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Icon(
                                                              Icons.camera),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "Change profile picture",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: AppConstants
                                                            .secondaryColor,
                                                        border: Border.all(
                                                          color: AppConstants
                                                              .secondaryColor!,
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .exit_to_app,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              Text(
                                                                " Sign out",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              title:
                  Consumer<ProfileViewModel>(builder: (context, value, child) {
                return TabBar(
                  controller: value.tabController,
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  labelColor: AppConstants.primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 60),
                  unselectedLabelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  indicatorWeight: 3,
                  indicatorColor: AppConstants.primaryColor,
                  tabs: [
                    Tab(
                      text: "Bought",
                    ),
                    Tab(text: "Favourites"),
                  ],
                );
              }),
            ),
          ],
          body: Consumer<ProfileViewModel>(builder: (context, value, child) {
            return TabBarView(
              controller: value.tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      CategoryProductView(
                          product: Product(1, "aaaaaaa", 13, 4.7,
                              ["assets/images/trees.png"], [], "", "", null),
                          bought: true),
                      CategoryProductView(
                          product: Product(
                              1,
                              "aaaaaaa",
                              23,
                              3.7,
                              ["assets/images/native_americans.png"],
                              [],
                              "",
                              "",
                              null),
                          bought: true),
                      CategoryProductView(
                          product: Product(1, "aaaaaaa", 23, 3.7,
                              ["assets/images/trees.png"], [], "", "", null),
                          bought: true)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      CategoryProductView(
                          product: Product(1, "aaaaaaa", 18, 1.7,
                              ["assets/images/whale.png"], [], "", "", null)),
                      CategoryProductView(
                          product: Product(
                              1,
                              "aaaaaaa",
                              23,
                              4.7,
                              ["assets/images/native_americans.png"],
                              [],
                              "",
                              "",
                              null)),
                      CategoryProductView(
                          product: Product(1, "aaaaaaa", 23, 0.7,
                              ["assets/images/trees.png"], [], "", "", null))
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
