import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/utils.dart';
import 'package:sales_app/features/category/model/category_model.dart';
import 'package:sales_app/features/category/services/category_service.dart';
import 'package:sales_app/features/product/services/poster_service.dart';

import '../../sign_page/view_model/user_info_view_model.dart';

class AddPageViewModel extends ChangeNotifier {
  CategoryService categoryService = CategoryService();
  PosterService posterService = PosterService();

  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  File? coverImage;

  List<File> listOfImages = [];
  List<Widget> carouselWidgets = [];
  List<GestureDetector> menuItems = [
    GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Choose"),
      ),
    ),
  ];

  bool menuItemsLoading = false;
  bool menuItemsLoaded = false;

  int scrollValue = 0;
  bool selectionIsOpen = false;

  String? _chosenCategory;
  XFile? _imageFile;
  File? nFile;
  XFile get imageFile => this._imageFile!;

  String? get chosenCategory => _chosenCategory;

  set chosenCategory(String? value) {
    _chosenCategory = value;
  }

  set imageFile(XFile value) => this._imageFile = value;
  dynamic _pickImageError;
  dynamic get pickImageError => this._pickImageError;

  final ImagePicker _picker = ImagePicker();

  set pickImageError(dynamic value) => this._pickImageError = value;

  openCategories() {
    print("Open called");
    selectionIsOpen = true;
    notifyListeners();
  }

  closeCategories() {
    print("Close called");
    selectionIsOpen = false;
    notifyListeners();
  }

  updateCategories() async {
    print("Categories getting updated..");
    final List<GestureDetector> menuItems2 = [];
    await categoryService.getCategories().then((value) {
      menuItemsLoading = true;
      notifyListeners();

      print(menuItemsLoading);
      for (var element in value) {
        print(element.getTitle);
        menuItems2.add(
          GestureDetector(
            onTap: () {
              _chosenCategory = element.getTitle;
              selectionIsOpen = false;
              notifyListeners();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Text(
                element.getTitle,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      }
      menuItems = menuItems2;
      menuItemsLoaded = true;
      menuItemsLoading = false;

      notifyListeners();
    });
  }

  addPoster({
    required BuildContext context,
  }) {
    print(chosenCategory);
    posterService.addPoster(
      context: context,
      title: titleController.text,
      categorie: chosenCategory!,
      price: double.parse(priceController.text),
      userId: Provider.of<UserInfoViewModel>(context, listen: false).user.id,
      files: listOfImages,
    );
  }

  updateScrollValue(int value) {
    scrollValue = value;
    notifyListeners();
  }

  selectImage(BuildContext context, String chosenFor) async {
    if (chosenFor == "Cover") {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      bool isCropped = false;
      imageFile = pickedFile!;

      coverImage = File(imageFile.path);
      cropImage(context, coverImage!).then(
        (value) {
          if (value != null) {
            coverImage = File(value!.path);

            isCropped = true;
            notifyListeners();
          } else {
            coverImage = null;
          }
        },
      );
      if (!isCropped) {
        coverImage = null;
      }
      notifyListeners();
    }
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
      bool isCropped = false;
      cropImage(context, File(imageFile.path)).then(
        (value) {
          if (value != null) {
            nFile = File(value.path);

            isCropped = true;
            notifyListeners();

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
            print("carousell " +
                carouselWidgets.length.toString() +
                2.toString());

            carouselWidgets.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: Consumer<AddPageViewModel>(
                  builder: (context, viewModel, child) {
                    return GestureDetector(
                      onTap: () {
                        viewModel.pickImage(context);
                      },
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.grey[300]!,
                              style: BorderStyle.solid),
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
                    );
                  },
                ),
              ),
            );
            listOfImages.add(nFile!);
            notifyListeners();
          } else {
            nFile = null;
          }
        },
      );
    } catch (e) {
      pickImageError = e;
    }
  }

  Future<CroppedFile?> cropImage(BuildContext context, File file) async {
    CroppedFile? croppedFile;
    if (file != null) {
      croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropping...',
            toolbarColor: AppConstants.secondaryColor,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: 'Cropping...',
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
            aspectRatioLockDimensionSwapEnabled: false,
            minimumAspectRatio: 1,
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
    }
    if (croppedFile != null) {
      return croppedFile;
    } else {
      return null;
    }
  }

  addNewCategory(String title, File coverImage) async {
    menuItemsLoading = true;
    notifyListeners();
    categoryService
        .addNewCategory(categoryController.value.text, coverImage)
        .then((value) {
      menuItemsLoading = false;
      notifyListeners();
      print("VAl " + value.toString());
      updateCategories();
    });
  }

  emptyPage(BuildContext context) {
    titleController.text = "";
    chosenCategory = null;
    double width = MediaQuery.of(context).size.width;

    carouselWidgets.clear();

    carouselWidgets = [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
        child: Consumer<AddPageViewModel>(
          builder: (context, viewModel, child) {
            return GestureDetector(
              onTap: () {
                viewModel.pickImage(context);
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
            );
          },
        ),
      ),
    ];

    listOfImages = [];
    priceController.text = "";
  }

  bool checkIfReady(BuildContext context) {
    if (titleController.text != "" &&
        chosenCategory != null &&
        carouselWidgets.length != 1 &&
        priceController.text != "") {
      return true;
    } else {
      showCustomSnack(context: context, text: "One or more fields are empty!");
      return false;
    }
  }
}
