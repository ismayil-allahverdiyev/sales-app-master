import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/product/view/starring_view.dart';
import 'package:sales_app/features/product/view_model/product_view_model.dart';

import '../../displayPage/view/display_view.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // print("height is: "+CupertinoTextField().cursorHeight!);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Logo",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, __, ___) => DisplayView(),
              ),
            );
          },
          child: CarouselSlider(
            items: [
              CarouselProduct(),
              CarouselProduct(),
              CarouselProduct(),
            ],
            options: CarouselOptions(
              height: height * 0.7,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 3,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
              pauseAutoPlayOnTouch: true,
              onPageChanged: (index, reason) => setState(() {
                currentIndex = index;
              }),
              enlargeFactor: 0.15,
            ),
          ),
        ),
      ],
    );
  }
}

class CarouselProduct extends StatelessWidget {
  const CarouselProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
      child: SizedBox(
        width: 400,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 400,
                height: height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/native_americans.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 400,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    "Native Americans Native Americans Native Americans Native Americans Native Americans",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.1,
                                height: width * 0.1,
                                child: Builder(builder: (context) {
                                  return FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // viewModel.checkIfFavourited();
                                        },
                                        child: const Image(
                                          image: AssetImage(
                                            // viewModel.isFavouritedAtDispose ==
                                            //         true
                                            //     ? "assets/icons/heart_fill.png"
                                            //     :
                                            "assets/icons/heart_fill.png",
                                          ),
                                          color:
                                              // viewModel
                                              //             .isFavouritedAtDispose ==
                                              //         false
                                              //     ? Colors.grey[500]
                                              //     :
                                              Colors.red,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<ProductViewModel>(
                                builder: (context, viewModel, _) {
                              return StarringView(
                                rate: viewModel.ratingSystem(0.6),
                                doubleRate: 0.6,
                              );
                            }),
                            Row(
                              children: [
                                Text("View more"),
                                Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  size: 16,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
