import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../../../core/constants/app_constants.dart';
import '../model/category_model.dart';

class CategoryService {
  List<CategoryModel> listOfCategories = [];

  Future<bool> addNewCategory(String title, File coverImage) async {
    try {
      CategoryService categoryService = CategoryService();
      CategoryModel category = CategoryModel(title: title, coverUrl: "");

      var request =
          http.MultipartRequest("POST", Uri.parse("$uri/newCategory"));
      request.fields["title"] = title;
      var mimeType = lookupMimeType(coverImage.path);
      var image = await coverImage.readAsBytes();
      var httpImage = http.MultipartFile.fromBytes("image", image,
          contentType: MediaType.parse(mimeType!), filename: coverImage.path);
      request.files.add(httpImage);

      request.send().then((response) {
        if (response.statusCode == 200) {
          print("New category added!");
          categoryService.getCategories();
          return true;
        } else {
          print("Category add failed!");
          return false;
        }
      });
    } on Exception catch (e) {
      print("Error happened while creating new category: " + e.toString());
      return false;
    }
    return false;
  }

  void getCategories() async {
    try {
      var request = await http
          .get(Uri.parse("$uri/categories"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      });

      var categories = jsonDecode(request.body);

      categories.forEach((element) {
        print(element);
      });
    } catch (e) {}
  }
}
