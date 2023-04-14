import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/addPage/view_model/add_page_view_model.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Consumer<AddPageViewModel>(builder: (context, viewModel, child) {
      return Column(
        children: [
          CarouselSlider(
            items: viewModel.carouselWidgets.length != 0
                ? viewModel.carouselWidgets
                : [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AddPageViewModel>(context, listen: false)
                              .closeCategories;
                          viewModel.pickImage(context);
                        },
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Colors.grey[300]!,
                                style: BorderStyle.solid),
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                color: Color(0xffF24E1E),
                                fontSize: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
            // Padding(
            //     padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            //     child: GestureDetector(
            //       onTap: () {
            //         viewModel.pickImage(context);
            //       },
            //       child: Container(
            //         width: width,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10.0),
            //           border: Border.all(
            //               color: Colors.grey[300]!, style: BorderStyle.solid),
            //         ),
            //         child: Center(
            //           child: Text(
            //             "+",
            //             style: TextStyle(
            //               color: Color(0xffF24E1E),
            //               fontSize: 50,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   )
            options: CarouselOptions(
              height: (width - 40) / 3 * 4,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 3,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
              pauseAutoPlayOnTouch: true,
              onPageChanged: (index, reason) =>
                  {viewModel.updateScrollValue(index)},
            ),
          ),
          CarouselIndicator(
            width: 10,
            height: 10,
            count: viewModel.carouselWidgets.isEmpty
                ? 1
                : viewModel.carouselWidgets.length,
            index: viewModel.scrollValue,
            activeColor: Colors.orange,
            color: Colors.grey[200]!,
          ),
        ],
      );
    });
  }
}
