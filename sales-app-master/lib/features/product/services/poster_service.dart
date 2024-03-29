import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';

import 'package:http_parser/http_parser.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/product/model/color_model.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/services/comment_service.dart';

class PosterService {
  getAllPosters({
    String? keyword,
    required String token,
    required List<String> categories,
    required int minPrice,
    required int maxPrice,
    required List<String> colorList,
  }) async {
    try {
      String cats = "";
      for (int i = 0; i < categories.length; i++) {
        cats +=
            "categories=${categories[i]}${(i + 1 < categories.length) ? "&" : ""}";
      }
      var link =
          "$uri/api/filteredSearch${keyword != null ? "?keyword=$keyword" : ""}&minPrice=$minPrice&maxPrice=$maxPrice${categories.length > 1 ? "&$cats" : categories.length == 1 ? "&categories=" + categories[0] : ""}${colorList.length > 1 ? "&${[
              for (int i = 0; i < colorList.length; i++)
                "colorList=${colorList[i]}${(i + 1 < colorList.length) ? "&" : ""}",
            ]}" : colorList.length == 1 ? "&colorList=" + colorList[0] : ""}&token=$token";

      print("link " + link);

      http.Response response = await http.get(
        Uri.parse(
          link,
        ),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print("Response is " + jsonDecode(response.body).toString());
      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
    }
  }

  getPosterById({
    required BuildContext context,
    required String posterId,
  }) async {
    try {
      http.Response response = await http.get(
          Uri.parse(uri + "/api/poster/getPosterById?posterId=" + posterId),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      print("Response is " + jsonDecode(response.body).toString());
      return jsonDecode(response.body);
    } catch (e) {
      return e.toString();
    }
  }

  void addPoster({
    required BuildContext context,
    required String userId,
    required String categorie,
    required double price,
    required String token,
    required String title,
    required List<File> files,
    required List<PosterColor> posterColors,
  }) async {
    var request =
        http.MultipartRequest("POST", Uri.parse(uri + "/api/addPoster"));

    request.fields["category"] = categorie;
    request.fields["price"] = price.toString();
    request.fields["title"] = title;
    request.fields["token"] = token;
    var colors = {};

    for (int i = 0; i < posterColors.length; i++) {
      request.fields["colorPalette[$i][colorName]"] =
          posterColors[i].colorName.toString();
      request.fields["colorPalette[$i][hexCode]"] = posterColors[i]
          .hexCode
          .substring(10, posterColors[i].hexCode.length - 1);
    }

    var mimeType;
    var val;
    var httpImage;
    for (int i = 0; i < files.length; i++) {
      mimeType = lookupMimeType(files[i].path);
      print("mimetype is $mimeType");

      val = await files[i].readAsBytes();
      httpImage = http.MultipartFile.fromBytes('image', val,
          contentType: MediaType.parse(mimeType!), filename: files[i].path);
      request.files.add(httpImage);
    }
    print(request.files);

    request.send().then((response) {
      if (response.statusCode == 200)
        print("Uploaded! " + response.stream.toString());
      print("Uploaded! rest" + response.stream.toString());
    });
  }

  void addVideoPoster({
    required BuildContext context,
    required String userId,
    required String categorie,
    required double price,
    required String title,
    required File file,
  }) async {
    final mimeType = lookupMimeType(file.path);

    print("mimetype is $mimeType");

    var request =
        http.MultipartRequest("POST", Uri.parse(uri + "/api/addVideoPoster"));
    request.fields["categorie"] = categorie;
    request.fields["userId"] = userId;
    request.fields["price"] = price.toString();
    request.fields["title"] = title;
    print(1);
    final val = await file.readAsBytes();
    print(2);

    final httpVideo = http.MultipartFile.fromBytes('video', val,
        contentType: MediaType.parse(mimeType!), filename: file.path);
    request.files.add(httpVideo);
    print(3);

    request.send().then((response) async {
      print("request rent");
      if (response.statusCode == 200) {
        print("Uploaded!");
      } else {
        final respStr = await response.stream.bytesToString();

        print("failed " + respStr.toString());
      }
    });
    print(4);
  }

  void getVideoPoster({required String filename}) async {
    final video = await http.get(
      Uri.parse(uri + "/api/files/95754c6a9c6bd0cc7b748ba182ab9c1c.jpeg"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );
    print(video.body);
  }
}
