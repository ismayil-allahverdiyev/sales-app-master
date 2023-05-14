import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/view/starring_view.dart';
import 'package:sales_app/features/product/view_model/product_view_model.dart';

import 'comment_view.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  bool isFocused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController =
        TabController(length: widget.product.images!.length, vsync: this);
    Provider.of<ProductViewModel>(context, listen: false).controller =
        ScrollController();
    tabController?.addListener(() {
      Provider.of<ProductViewModel>(context, listen: false).currentIndex =
          tabController!.index;
    });
    Provider.of<ProductViewModel>(context, listen: false)
        .loadThePage(widget.product);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Provider.of<ProductViewModel>(context, listen: false).dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          isFocused = false;
        },
        child: CustomScrollView(
          controller:
              Provider.of<ProductViewModel>(context, listen: false).controller,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: width / 3 * 4,
              flexibleSpace: FlexibleSpaceBar(
                background: DefaultTabController(
                  length: widget.product.images!.length,
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
                                  count: widget.product.images!.length,
                                  index: productViewModel.currentIndex,
                                  color: Colors.grey[300]!,
                                  activeColor: AppConstants.primaryColor,
                                ),
                              ],
                            ),
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
                              widget.product.categorie,
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
                                  widget.product.title,
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
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage("assets/icons/heart.png"),
                                color: widget.product.favs != []
                                    ? Colors.grey[700]
                                    : Colors.red,
                              ),
                            ),
                          ),
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
                                "${widget.product.price}\$",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                              child: Consumer<ProductViewModel>(
                                builder: (context, value, child) =>
                                    StarringView(
                                  rate: value.rateList,
                                  doubleRate: widget.product.rate,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                              color: AppConstants.secondaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        )
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
                          Provider.of<ProductViewModel>(context, listen: false)
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
                    height: 2,
                    color: Colors.grey[300],
                  ),
                  Consumer<ProductViewModel>(builder: (context, viewModel, _) {
                    print("viewModel.commentsLoading " +
                        viewModel.commentsLoading.toString());
                    return viewModel.commentsLoading
                        ? CircularProgressIndicator()
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
                                    posterId: widget.product.id,
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
