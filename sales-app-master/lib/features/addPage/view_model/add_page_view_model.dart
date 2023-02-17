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

  List<File> listOfImages = [];

  List<Widget> carouselWidgets = [];

  int scrollValue = 0;

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

  updateScrollValue(int value) {
    scrollValue = value;
    notifyListeners();
  }

  pickImage(BuildContext context) async {
    try {
      double width = MediaQuery.of(context).size.width;

      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      imageFile = pickedFile!;
      print("Chosen");
      print(imageFile);
      nFile = File(imageFile.path);
      print("carousell " + carouselWidgets.length.toString());
      if (carouselWidgets.length != 0) {
        carouselWidgets.insert(
          carouselWidgets.length - 1,
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: SizedBox(
              width: width,
              child: Card(
                margin: EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    nFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        carouselWidgets.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: SizedBox(
              width: width,
              child: Card(
                margin: EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    nFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }
      if (carouselWidgets.length != 1) {
        carouselWidgets.removeLast();
      }
      print("carousell " + carouselWidgets.length.toString() + 2.toString());

      // carouselWidgets.add(
      //   Padding(
      //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      //     child: SizedBox(
      //       width: width,
      //       child: Card(
      //         margin: EdgeInsets.all(8.0),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10.0),
      //         ),
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(10.0),
      //           child: Image.file(
      //             nFile!,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // );
      carouselWidgets.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
        child: GestureDetector(
          onTap: () {
            pickImage(context);
          },
          child: Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: Colors.grey[300]!, style: BorderStyle.solid),
            ),
            child: Center(
              child: Text(
                "+",
                style: TextStyle(
                  color: Color(0xffF24E1E),
                  fontSize: 50,
                ),
              ),
            ),
          ),
        ),
      ));
      listOfImages.add(nFile!);
      notifyListeners();
    } catch (e) {
      pickImageError = e;
    }
  }
}
