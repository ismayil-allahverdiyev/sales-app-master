import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_constants.dart';

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

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            "Logo",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          CarouselSlider(
            items: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: SizedBox(
                  width: 400,
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          "assets/images/native_americans.png",
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: SizedBox(
                  width: 400,
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          "assets/images/whale.png",
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: SizedBox(
                  width: 400,
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          "assets/images/trees.png",
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 250.0,
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
            ),
          ),
          CarouselIndicator(
            count: 4,
            index: currentIndex,
            activeColor: Colors.orange,
            color: Colors.grey[200]!,
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: CupertinoTextField(
              placeholder: "Search...",
              prefix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage("assets/icons/search_home.png"),
                  color: Colors.grey,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey[300]!,
                    style: BorderStyle.solid,
                    width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              cursorColor: AppConstants.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
