import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/features/category/model/category_model.dart';
import 'package:sales_app/features/category/view/category_product_view.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/view/product_view.dart';
import 'package:sales_app/features/search/services/search_service.dart';

class CategoryViewModel extends ChangeNotifier {
  SearchService searchService = SearchService();

  List<Product> listOfProducts = [];
  CategoryModel? searchedCategory;

  bool _isLoaded = false;
  bool get isLoaded => this._isLoaded;
  set isLoaded(bool value) => this._isLoaded = value;

  getPostersByCategory(CategoryModel category) async {
    print("Getting categories");
    listOfProducts.clear();
    listOfProducts =
        await searchService.getPostersByCategory(category: category);
    // categories.forEach((element) => listOfProducts.add(Column(
    //       children: [
    //         CategoryProductView(
    //           product: element,
    //         ),
    //         Divider(
    //           color: Colors.grey[300],
    //           endIndent: 16,
    //           indent: 16,
    //           thickness: 2,
    //         )
    //       ],
    //     )));
    searchedCategory = category;
    isLoaded = true;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isLoaded = false;
    print("CategoryViewModel disposed");
    super.dispose();
  }
}
