import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sales_app/features/addPage/view_model/add_page_view_model.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/utils.dart';
import '../model/category_model.dart';

class CategoryService {
  List<CategoryModel> listOfCategories = [];

  Future<bool> addNewCategory(String title, File coverImage) async {
    try {
      CategoryModel category =
          CategoryModel(title: title, coverUrl: "", count: 0);

      var request =
          http.MultipartRequest("POST", Uri.parse("$uri/newCategory"));
      request.fields["title"] = title;
      var mimeType = lookupMimeType(coverImage.path);
      var image = await coverImage.readAsBytes();
      var httpImage = http.MultipartFile.fromBytes("image", image,
          contentType: MediaType.parse(mimeType!), filename: coverImage.path);
      request.files.add(httpImage);

      await request.send().then((response) {
        if (response.statusCode == 200) {
          print("New category added!");

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

  getCategories() async {
    try {
      var request = await http
          .get(Uri.parse("$uri/categories"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      });

      var categories = jsonDecode(request.body);
      listOfCategories.clear();
      categories.forEach((element) {
        listOfCategories.add(CategoryModel.fromMap(element));
      });

      return categories;
    } catch (e) {
      print(e.toString());
    }
  }
}
