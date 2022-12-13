import 'package:carousel_indicator/carousel_indicator.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController =
        TabController(length: widget.product.images!.length, vsync: this);
    tabController?.addListener(() {
      Provider.of<ProductViewModel>(context, listen: false).currentIndex =
          tabController!.index;
    });
    Provider.of<ProductViewModel>(context, listen: false)
        .setImageWidgets(widget.product.images!);
    Provider.of<ProductViewModel>(context, listen: false)
        .ratingSystem(widget.product.rate);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: width / 2 + 16,
            child: Stack(
              children: [
                Consumer<ProductViewModel>(
                  builder: ((context, value, child) => TabBarView(
                        controller: tabController,
                        children: value.imageWidgets,
                      )),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: width * 0.08,
                      height: width * 0.08,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Consumer<ProductViewModel>(
              builder: (context, productViewModel, child) => CarouselIndicator(
                count: widget.product.images!.length,
                index: productViewModel.currentIndex,
                color: Colors.grey[300]!,
                activeColor: AppConstants.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Text(
              widget.product.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " ${widget.product.price}\$",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Consumer<ProductViewModel>(
                      builder: (context, value, child) => StarringView(
                        rate: value.rateList,
                        doubleRate: widget.product.rate,
                      ),
                    )
                  ],
                ),
                Container(
                  width: width / 4,
                  height: width / 10,
                  decoration: BoxDecoration(
                      color: AppConstants.secondaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 12, 4),
            child: Text(
              "Comments",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1),
            ),
          ),
          Divider(
            indent: 8,
            thickness: 3,
            endIndent: width / 2,
            height: 3,
            color: Colors.grey[300],
          ),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              CommentView(),
              CommentView(),
              CommentView(),
            ],
          )
        ],
      ),
    );
  }
}
