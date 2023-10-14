import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/utils.dart';
import 'package:sales_app/features/category/model/category_model.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/services/poster_service.dart';
import 'package:sales_app/features/search/services/search_service.dart';
import '../../category/services/category_service.dart';
import '../../sign_page/view_model/user_info_view_model.dart';
import '../models/color_model.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel() {
    handleInitPage();
  }

  PosterService posterService = PosterService();
  SearchService searchService = SearchService();
  CategoryService categoryService = CategoryService();

  List<CategoryModel> searchedCategories = [];
  List<Product> searchedProducts = [];
  List<int> selectedCategories = [];

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

  bool isColorListOn = false;

  RangeValues currentRangeValues = const RangeValues(0, 100000);
  RangeValues get getCurrentRangeValues => this.currentRangeValues;
  set setCurrentRangeValues(RangeValues currentRangeValues) =>
      this.currentRangeValues = currentRangeValues;

  String minValue = "0";
  String get getMinValue => this.minValue;
  set setMinValue(String minValue) => this.minValue = minValue;

  String maxValue = "100000";
  String get getMaxValue => this.maxValue;
  set setMaxValue(String miaxValue) => this.maxValue = maxValue;

  List<ColorModel> colors = [];
  List<bool> selectedColors = [];

  getAllPosters() async {
    try {
      productLoading = true;
      notifyListeners();
      List res = await posterService.getAllPosters(
        token: Provider.of<UserInfoViewModel>(snackbarKey.currentContext!,
                listen: false)
            .user
            .token,
        categories: [
          for (int i = 0; i < selectedCategories.length; i++)
            allCategories[selectedCategories[i]].title
        ],
        colorList: [
          for (int i = 0; i < selectedColors.length; i++)
            if (selectedColors[i]) colors[i].colorName,
        ],
        keyword: searchController.text,
        maxPrice: int.parse(maxValue),
        minPrice: int.parse(minValue),
      );
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
    selectedCategories.clear();
    res.forEach((element) {
      allCategories.add(CategoryModel.fromMap(element));
    });

    categoryLoading = false;
    notifyListeners();
  }

  searchStaticData(String keyword) {
    selectedCategories.clear();
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
    getAllPosters();
    getAllCategories();
    getAllColors();
  }

  setRangeValues(RangeValues value) {
    currentRangeValues = value;
    minValue = "${value.start.round()}";
    maxValue = "${value.end.round()}";
    notifyListeners();
  }

  getAllColors() async {
    if (snackbarKey.currentContext != null) {
      var response = await searchService.getAllColors();

      var result = [
        for (int i = 0; i < response.length; i++)
          ColorModel.fromJson(response[i])
      ];
      if (result.isNotEmpty) {
        colors = result;
        selectedColors = List.generate(colors.length, (index) => false);
      } else {
        showCustomSnack(text: "No colors found");
      }
    } else {
      showCustomSnack(text: "Something went wrong");
    }
  }

  turnColorListOnOff() {
    isColorListOn = !isColorListOn;
    notifyListeners();
  }

  void selectColor({
    required int index,
  }) {
    selectedColors[index] = !selectedColors[index];
    print("WORKED" + selectedColors.toString());
    notifyListeners();
  }

  selectCategory(int index) {
    selectedCategories.contains(index)
        ? selectedCategories.remove(index)
        : selectedCategories.add(index);
    notifyListeners();
    getAllPosters();
  }
}
