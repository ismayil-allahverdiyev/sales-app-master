import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/features/category/model/category_model.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/services/poster_service.dart';
import '../../category/services/category_service.dart';

class SearchViewModel extends ChangeNotifier {
  PosterService posterService = PosterService();
  CategoryService categoryService = CategoryService();

  List<CategoryModel> searchedCategories = [];
  List<Product> searchedProducts = [];

  List<CategoryModel> allCategories = [];
  List<Product> allProducts = [];

  TextEditingController searchController = TextEditingController();
  TextEditingController minValueController = TextEditingController();
  TextEditingController maxValueController = TextEditingController();

  bool _searchIsOn = false;
  bool get searchIsOn => this._searchIsOn;
  set searchIsOn(bool value) => this._searchIsOn = value;

  bool _loaded = false;
  bool get loaded => this._loaded;
  set loaded(bool value) => this._loaded = value;

  bool _productLoading = false;
  bool get productLoading => this._productLoading;
  set productLoading(bool value) => this._productLoading = value;

  bool _categoryLoading = false;
  bool get categoryLoading => this._categoryLoading;
  set categoryLoading(bool value) => this._categoryLoading = value;

  RangeValues currentRangeValues = const RangeValues(0, 1000);
  RangeValues get getCurrentRangeValues => this.currentRangeValues;
  set setCurrentRangeValues(RangeValues currentRangeValues) =>
      this.currentRangeValues = currentRangeValues;

  String minValue = "0";
  String get getMinValue => this.minValue;
  set setMinValue(String minValue) => this.minValue = minValue;

  String maxValue = "100";
  String get getMaxValue => this.maxValue;
  set setMaxValue(String miaxValue) => this.maxValue = maxValue;

  getAllPosters() async {
    try {
      productLoading = true;
      List res = await posterService.getAllPosters();
      allProducts.clear();
      res.forEach((element) {
        allProducts.add(Product.fromMap(element));
      });
      productLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getAllCategories() async {
    categoryLoading = true;
    List res = await categoryService.getCategories();
    allCategories.clear();
    res.forEach((element) {
      allCategories.add(CategoryModel.fromMap(element));
    });

    categoryLoading = false;
    notifyListeners();
  }

  searchStaticData(String keyword) {
    searchedCategories = allCategories
        .where((element) =>
            element.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    print(searchedCategories.toString());

    searchedProducts = allProducts
        .where((element) =>
            element.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    print(searchedProducts.toString());
  }

  handleStaticSearch(String value) {
    searchStaticData(value);
    if (value.isEmpty) {
      searchIsOn = false;
      notifyListeners();
    } else {
      searchIsOn = true;
      notifyListeners();
    }
  }

  handleInitPage() {
    if (!loaded) {
      getAllPosters();
      getAllCategories();
      loaded = true;
    }
  }

  setRangeValues(RangeValues value) {
    currentRangeValues = value;
    minValue = "${value.start.round()}";
    maxValue = "${value.end.round()}";
    notifyListeners();
  }
}
