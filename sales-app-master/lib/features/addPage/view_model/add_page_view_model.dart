import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';

class AddPageViewModel extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController categorieController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  XFile? _imageFile;
  File? nFile;
  XFile get imageFile => this._imageFile!;

  set imageFile(XFile value) => this._imageFile = value;
  dynamic _pickImageError;
  dynamic get pickImageError => this._pickImageError;

  final ImagePicker _picker = ImagePicker();

  set pickImageError(dynamic value) => this._pickImageError = value;

  upload() async {
    File file = File(imageFile!.path);
    var stream = http.ByteStream(DelegatingStream(file.openRead()));

    var length = await file.length();

    var parsedUri = Uri.parse("$uri/api/addPoster");
    var request = new http.MultipartRequest("POST", parsedUri);

    var multipartFile = http.MultipartFile("myFile", stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  pickImage(BuildContext context) async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.gallery,
      );

      imageFile = pickedFile!;
      print("Chosen");
      print(imageFile);
      nFile = File(imageFile.path);
      notifyListeners();
    } catch (e) {
      pickImageError = e;
    }
  }
}
