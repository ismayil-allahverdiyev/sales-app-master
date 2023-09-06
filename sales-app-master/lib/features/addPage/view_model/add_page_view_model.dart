import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/utils.dart';
import 'package:sales_app/features/category/model/category_model.dart';
import 'package:sales_app/features/category/services/category_service.dart';
import 'package:sales_app/features/product/model/color_model.dart';
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
  List<Widget> colorPaletteWidgetList = [];
  List<PosterColor> colorPaletteList = [];
  List<GestureDetector> menuItems = [
    GestureDetector(
      child: const Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Choose"),
      ),
    ),
  ];

  bool menuItemsLoading = false;
  bool menuItemsLoaded = false;

  int scrollValue = 0;
  bool selectionIsOpen = false;

  File? nFile;

  XFile? _imageFile;
  XFile get imageFile => this._imageFile!;
  set imageFile(XFile value) => this._imageFile = value;

  String? _chosenCategory;
  String? get chosenCategory => _chosenCategory;
  set chosenCategory(String? value) {
    _chosenCategory = value;
  }

  dynamic _pickImageError;
  dynamic get pickImageError => this._pickImageError;
  set pickImageError(dynamic value) => this._pickImageError = value;

  final ImagePicker _picker = ImagePicker();

  Color? _currentChosenColor;
  Color? get currentChosenColor => _currentChosenColor;
  set currentChosenColor(Color? value) {
    _currentChosenColor = value;
  }

  String? _currentChosenColorName;
  String? get currentChosenColorName => _currentChosenColorName;
  set currentChosenColorName(String? value) {
    _currentChosenColorName = value;
  }

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
        CategoryModel category = CategoryModel.fromMap(element);
        print(element.toString() + " element");
        menuItems2.add(
          GestureDetector(
            onTap: () {
              _chosenCategory = category.getTitle;
              selectionIsOpen = false;
              notifyListeners();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Text(
                category.getTitle,
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
      posterColors: colorPaletteList,
      token: Provider.of<UserInfoViewModel>(
        context,
        listen: false,
      ).user.token,
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

      nFile = File(imageFile.path);
      bool isCropped = false;
      cropImage(context, File(imageFile.path)).then(
        (value) {
          if (value != null) {
            nFile = File(value.path);

            isCropped = true;
            notifyListeners();

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
                child: const Center(
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

    colorPaletteList.clear();
    colorPaletteWidgetList.clear();

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
      showCustomSnack(text: "One or more fields are empty!");
      return false;
    }
  }

  addColorToTheList() {
    var poster = PosterColor(
        colorName: currentChosenColorName!,
        hexCode: currentChosenColor.toString());
    bool exist = colorPaletteList.any((item) =>
        item.colorName == poster.colorName && item.hexCode == poster.hexCode);
    if (currentChosenColor != null &&
        currentChosenColorName != null &&
        !exist) {
      colorPaletteList.add(poster);
      colorPaletteWidgetList.add(
        PaletteWidget(
          color: currentChosenColor!,
          colorName: currentChosenColorName!,
        ),
      );
      notifyListeners();
    }
  }

  removeFromTheList({required Color color}) {
    // int index = colorPaletteList.indexOf(color);
    // colorPaletteList.removeAt(index);
    // colorPaletteWidgetList.removeAt(index);
    notifyListeners();
  }
}

class PaletteWidget extends StatelessWidget {
  const PaletteWidget({
    super.key,
    required this.color,
    required this.colorName,
  });
  final Color color;
  final String colorName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey[200]!,
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: color,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(colorName),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Consumer<AddPageViewModel>(builder: (context, viewModel, _) {
            return IconButton(
              onPressed: () {
                Provider.of<AddPageViewModel>(context, listen: false)
                    .removeFromTheList(color: color);
              },
              icon: const Icon(Icons.cancel),
            );
          }),
        ],
      ),
    );
  }
}
