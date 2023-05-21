import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/category/model/category_model.dart';
import 'package:sales_app/features/category/view/category_product_loading.dart';
import 'package:sales_app/features/category/view/category_product_view.dart';
import 'package:sales_app/features/category/view_model/category_view_model.dart';
import 'package:sales_app/features/search/services/search_service.dart';

import '../../../core/constants/app_constants.dart';
import '../../product/model/product_model.dart';

class CategoryView extends StatelessWidget {
  CategoryView({Key? key, required this.category}) : super(key: key);
  final CategoryModel category;

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
      body: Consumer<CategoryViewModel>(
        builder: (context, viewModel, child) {
          if (!viewModel.isLoaded) {
            viewModel.getPostersByCategory(category);
          }
          return viewModel.isLoaded == false
              ? CategoryProductLoading()
              : ListView.builder(
                  itemCount: viewModel.listOfProducts.length,
                  itemBuilder: (context, index) {
                    print(index);
                    return Column(
                      children: [
                        CategoryProductView(
                          product: viewModel.listOfProducts[index],
                        ),
                        Divider(
                          color: Colors.grey[300],
                          endIndent: 16,
                          indent: 16,
                          thickness: 2,
                        )
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
