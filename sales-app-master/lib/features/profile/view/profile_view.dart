import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/category/view/category_product_loading.dart';
import 'package:sales_app/features/category/view/category_product_view.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';

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
    Provider.of<ProfileViewModel>(context, listen: false).loadPage(
      token: Provider.of<UserInfoViewModel>(context, listen: false).user.token,
    );
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
                            Consumer<ProfileViewModel>(
                                builder: (context, viewModel, _) {
                              return CachedNetworkImage(
                                imageUrl: viewModel.profileInfo.imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: width * 0.2,
                                  backgroundImage: imageProvider,
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.person,
                                  color: AppConstants.secondaryColor,
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: width * 0.05,
                        ),
                        Consumer<ProfileViewModel>(
                            builder: (context, viewModel, _) {
                          return Text(
                            viewModel.profileInfo.name.capitalize,
                            style: TextStyle(
                              fontSize: height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                        child: IconButton(
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppConstants.primaryColor,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Consumer<ProfileViewModel>(
                                      builder: (context, viewModel, _) {
                                    return Column(
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
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
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
                                                child: Material(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          viewModel.signOut(
                                                              context: context);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppConstants
                                                                .secondaryColor,
                                                            border: Border.all(
                                                              color: AppConstants
                                                                  .secondaryColor!,
                                                              style: BorderStyle
                                                                  .solid,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              },
                            );
                          },
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
              title: Consumer<ProfileViewModel>(
                builder: (context, viewModel, child) {
                  return TabBar(
                    controller: viewModel.tabController,
                    labelStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    labelColor: AppConstants.primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 60),
                    unselectedLabelStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    indicatorWeight: 3,
                    indicatorColor: AppConstants.primaryColor,
                    tabs: const [
                      Tab(text: "Favourites"),
                      Tab(
                        text: "Bought",
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          body: Consumer<ProfileViewModel>(
            builder: (context, viewModel, child) {
              return TabBarView(
                controller: viewModel.tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                    child: viewModel.favsIsLoading
                        ? const CategoryProductLoading()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: viewModel.favourites.length,
                            itemBuilder: (context, index) {
                              return CategoryProductView(
                                product: viewModel.favourites[index],
                                isReloadable: true,
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                    child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
