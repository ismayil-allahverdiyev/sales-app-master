import 'package:flutter/cupertino.dart';
import 'package:sales_app/features/category/model/category_model.dart';
import 'package:sales_app/features/category/services/category_service.dart';
import 'package:sales_app/features/home/view/insight.dart';

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel() {
    if (listOfCategories.isEmpty) {
      getCategories();
    }
  }

  CategoryService categoryService = CategoryService();

  List<Insight> _listOfCategories = [];

  List<Insight> get listOfCategories => _listOfCategories;

  set listOfCategories(List<Insight> value) {
    _listOfCategories = value;
  }

  bool listLoading = false;

  getCategories() async {
    listLoading = true;
    notifyListeners();
    listOfCategories = [];

    await categoryService.getCategories().then((value) {
      for (var element in value) {
        if (element["count"] > 0) {
          listOfCategories
              .add(Insight(category: CategoryModel.fromMap(element)));
        }
      }
    });
    listLoading = false;
    notifyListeners();
  }
}
