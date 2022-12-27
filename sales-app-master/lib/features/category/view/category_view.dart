import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/features/category/view/category_product_view.dart';

import '../../../core/constants/app_constants.dart';
import '../../product/model/product_model.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CupertinoTextField(
          placeholder: "Search...",
          padding: EdgeInsets.all(8),
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
