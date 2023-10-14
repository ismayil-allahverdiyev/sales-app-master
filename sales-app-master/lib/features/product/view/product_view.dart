import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/basket/models/basket_product_model.dart';
import 'package:sales_app/features/basket/services/basket_service.dart';
import 'package:sales_app/features/basket/view_model/basket_view_model.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/view/comment_view_loading.dart';
import 'package:sales_app/features/product/view/product_view_loading.dart';
import 'package:sales_app/features/product/view/starring_view.dart';
import 'package:sales_app/features/product/view_model/product_view_model.dart';
import 'package:sales_app/features/profile/view_model/profile_view_model.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';
import 'package:shimmer/shimmer.dart';

import 'comment_view.dart';

class ProductView extends StatefulWidget {
  ProductView({Key? key, this.product, this.reloadableProduct})
      : super(key: key);
  Product? product;
  ReloadableProductModel? reloadableProduct;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  bool isFocused = false;

  ProductViewModel? productViewModelProvider;
  UserInfoViewModel? userInfoViewModelProvider;
  ProfileViewModel? profileViewModelProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ProductViewModel>(context, listen: false)
        .loadThePage(widget.product, context, widget.reloadableProduct)
        .then((value) {
      tabController = TabController(
        length: Provider.of<ProductViewModel>(context, listen: false)
            .currentProduct!
            .images!
            .length,
        vsync: this,
      );
      tabController?.addListener(() {
        Provider.of<ProductViewModel>(context, listen: false).currentIndex =
            tabController!.index;
      });
    });
  }

  @override
  void didChangeDependencies() {
    productViewModelProvider =
        Provider.of<ProductViewModel>(context, listen: false);
    profileViewModelProvider =
        Provider.of<ProfileViewModel>(context, listen: false);
    userInfoViewModelProvider = Provider.of<UserInfoViewModel>(
      context,
      listen: false,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productViewModelProvider!.customDispose(
      token: userInfoViewModelProvider!.user.token,
      posterId: productViewModelProvider!.currentProduct!.id,
      profileViewModel: profileViewModelProvider!,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (Provider.of<ProductViewModel>(context, listen: true)
        .getProductIsLoading) {
      return Container(
        width: width,
        height: height,
        color: Colors.white,
        child: const ProductViewLoading(),
      );
    } else {
      return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            isFocused = false;
          },
          child: CustomScrollView(
            controller: Provider.of<ProductViewModel>(context, listen: false)
                .controller,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: width / 3 * 4,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Provider.of<ProductViewModel>(context, listen: false)
                        .disposeWidgets();
                    Navigator.pop(context);
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: DefaultTabController(
                    length:
                        Provider.of<ProductViewModel>(context, listen: false)
                            .currentProduct!
                            .images!
                            .length,
                    child: Consumer<ProductViewModel>(
                      builder: (context, value, child) => Stack(
                        alignment: Alignment.center,
                        children: [
                          TabBarView(
                            controller: tabController,
                            children: value.imageWidgets,
                          ),
                          Positioned(
                            bottom: 20,
                            child: Consumer<ProductViewModel>(
                              builder: (context, productViewModel, child) =>
                                  Stack(
                                children: [
                                  CarouselIndicator(
                                    count: Provider.of<ProductViewModel>(
                                            context,
                                            listen: false)
                                        .currentProduct!
                                        .images!
                                        .length,
                                    index: productViewModel.currentIndex,
                                    color: Colors.grey[300]!,
                                    activeColor: AppConstants.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            right: 0,
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i <
                                        ((Provider.of<ProductViewModel>(context,
                                                        listen: false)
                                                    .currentProduct!
                                                    .colors!
                                                    .length >=
                                                3)
                                            ? 3
                                            : Provider.of<ProductViewModel>(
                                                    context,
                                                    listen: false)
                                                .currentProduct!
                                                .colors!
                                                .length);
                                    i++)
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                          width: 2,
                                        ),
                                        color: Provider.of<ProductViewModel>(
                                                context,
                                                listen: false)
                                            .currentProduct!
                                            .colors![i],
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                              child: Text(
                                Provider.of<ProductViewModel>(context,
                                        listen: false)
                                    .currentProduct!
                                    .categorie,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: width / 3 * 2,
                                  child: Text(
                                    Provider.of<ProductViewModel>(context,
                                            listen: false)
                                        .currentProduct!
                                        .title,
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                          child: Container(
                            width: width * 0.1,
                            height: width * 0.1,
                            child: Consumer<ProductViewModel>(
                                builder: (context, viewModel, _) {
                              return viewModel.checkingTheFavourites
                                  ? LikeLoading()
                                  : FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            viewModel.checkIfFavourited();
                                          },
                                          child: Image(
                                            image: AssetImage(
                                              viewModel.isFavouritedAtDispose ==
                                                      true
                                                  ? "assets/icons/heart_fill.png"
                                                  : "assets/icons/heart.png",
                                            ),
                                            color: viewModel
                                                        .isFavouritedAtDispose ==
                                                    false
                                                ? Colors.grey[500]
                                                : Colors.red,
                                          ),
                                        ),
                                      ),
                                    );
                            }),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  "${Provider.of<ProductViewModel>(context, listen: false).currentProduct!.price}\$",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                child: Consumer<ProductViewModel>(
                                  builder: (context, value, child) =>
                                      StarringView(
                                    rate: value.rateList,
                                    doubleRate: Provider.of<ProductViewModel>(
                                            context,
                                            listen: false)
                                        .currentProduct!
                                        .rate,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Consumer<ProductViewModel>(
                              builder: (context, productViewModel, child) {
                            return SizedBox(
                              width: width / 6,
                              height: width / 12,
                              child: GestureDetector(
                                onTap: () {
                                  print("Is in the basket " +
                                      productViewModel.inTheBasket.toString());
                                  productViewModel.inTheBasket
                                      ? productViewModel
                                          .removeProductFromBasket(
                                          token: Provider.of<UserInfoViewModel>(
                                            context,
                                            listen: false,
                                          ).user.token,
                                          posterId:
                                              Provider.of<ProductViewModel>(
                                                      context,
                                                      listen: false)
                                                  .currentProduct!
                                                  .id,
                                          context: context,
                                        )
                                      : productViewModel.addProductToTheBasket(
                                          token: Provider.of<UserInfoViewModel>(
                                            context,
                                            listen: false,
                                          ).user.token,
                                          posterId:
                                              Provider.of<ProductViewModel>(
                                                      context,
                                                      listen: false)
                                                  .currentProduct!
                                                  .id,
                                          context: context,
                                        );
                                },
                                child: Card(
                                  color: productViewModel.checkingTheBasket
                                      ? Color(0xffFFAF85)
                                      : AppConstants.secondaryColor,
                                  child: FittedBox(
                                    child: productViewModel.checkingTheBasket
                                        ? Padding(
                                            padding: EdgeInsets.all(8),
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : productViewModel.inTheBasket == true
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Image(
                                                  image: AssetImage(
                                                    "assets/icons/bagTicked.png",
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "  Add  ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 1.2,
                                                  ),
                                                ),
                                              ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 8, 0, 4),
                          child: Text(
                            "Comments",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<ProductViewModel>(context,
                                    listen: false)
                                .scrollDown();
                            isFocused = true;
                          },
                          icon: const Icon(
                            CupertinoIcons.square_pencil,
                            color: AppConstants.iconColor,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      indent: 8,
                      thickness: 2,
                      endIndent: width / 2,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    Consumer<ProductViewModel>(
                        builder: (context, viewModel, _) {
                      print("viewModel.commentsLoading " +
                          viewModel.commentsLoading.toString());
                      return viewModel.commentsLoading
                          ? CommentViewLoading()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: viewModel.commentList.length,
                              itemBuilder: (context, index) => CommentView(
                                  comment: viewModel.commentList[index]),
                            );
                    }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 30),
                      child: Consumer<ProductViewModel>(
                        builder: (context, viewmodel, _) {
                          return TextField(
                            autofocus: isFocused,
                            controller: viewmodel.commentController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    viewmodel.sendComment(
                                      description:
                                          viewmodel.commentController.text,
                                      posterId: Provider.of<ProductViewModel>(
                                              context,
                                              listen: false)
                                          .currentProduct!
                                          .id,
                                      context: context,
                                    );
                                    viewmodel.commentController.text = "";
                                    FocusScope.of(context).unfocus();
                                    isFocused = false;
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.paperplane_fill,
                                  )),
                              hintText: "Write a comment...",
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class LikeLoading extends StatelessWidget {
  const LikeLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, viewModel, _) {
      return Shimmer(
        gradient: LinearGradient(colors: [
          Colors.grey[300]!,
          Colors.grey[200]!,
        ]),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                viewModel.checkIfFavourited();
              },
              child: Image(
                image: AssetImage("assets/icons/heart_fill.png"),
                color: viewModel.isFavouritedAtDispose == false
                    ? Colors.grey[700]
                    : Colors.red,
              ),
            ),
          ),
        ),
      );
    });
  }
}
