import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/category/view/category_product_view.dart';
import 'package:sales_app/features/product/services/poster_service.dart';
import 'package:sales_app/features/search/view_model/search_view_model.dart';

import '../../../core/constants/app_constants.dart';
import '../../product/model/product_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  PosterService posterService = PosterService();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    posterService.getAllPosters(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: CupertinoTextField(
          placeholder: "Search...",
          prefix: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage("assets/icons/searchNav.png"),
              color: Colors.grey,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey[300]!, style: BorderStyle.solid, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          cursorColor: AppConstants.primaryColor,
        ),
      ),
      body: ListView(
        children: [
          CategoryProductView(
              product: Product(
                  0,
                  "Mountain view and beautiful trees with lightining striking the town in the corner!",
                  23,
                  5,
                  ["assets/images/bird.png", "assets/images/whale.png"],
                  [],
                  "",
                  "",
                  null)),
          CategoryProductView(
              product: Product(
                  0,
                  "Mountain view and beautiful trees with lightining striking the town in the corner!",
                  27,
                  5,
                  ["assets/images/bird.png", "assets/images/whale.png"],
                  [],
                  "",
                  "",
                  null)),
          CategoryProductView(
              product: Product(
                  0,
                  "Mountain view and beautiful trees with lightining striking the town in the corner!",
                  27,
                  5,
                  ["assets/images/bird.png", "assets/images/whale.png"],
                  [],
                  "",
                  "",
                  null)),
          CategoryProductView(
              product: Product(
                  0,
                  "Mountain view and beautiful trees with lightining striking the town in the corner!",
                  27,
                  5,
                  ["assets/images/bird.png", "assets/images/whale.png"],
                  [],
                  "",
                  "",
                  null)),
        ],
      ),
    );
  }
}
