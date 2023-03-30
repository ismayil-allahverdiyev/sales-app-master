import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/addPage/view/carousel.dart';
import 'package:sales_app/features/addPage/view_model/add_page_view_model.dart';
import 'package:sales_app/features/category/services/category_service.dart';
import 'package:sales_app/features/product/services/poster_service.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';

class AddPageView extends StatelessWidget {
  const AddPageView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[700],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: (() {
          unFocus(context);
        }),
        child: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Text(
                    "Title",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: CupertinoTextField(
                    controller:
                        Provider.of<AddPageViewModel>(context, listen: false)
                            .titleController,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Consumer<AddPageViewModel>(
                        builder: (context, viewModel, child) {
                      return DropdownButtonFormField(
                        hint: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Select",
                          ),
                        ),
                        isDense: true,
                        isExpanded: true,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey[300]!,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey[300]!,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey[300]!,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey[300]!,
                            ),
                          ),
                        ),
                        items: viewModel.menuItems,
                        onChanged: (value) {},
                      );
                    }),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      builder: (context) {
                        return Consumer<AddPageViewModel>(
                          builder: (context, viewModel, child) => Padding(
                            // padding: const EdgeInsets.all(8.0),
                            padding: MediaQuery.of(context).viewInsets,
                            child: GestureDetector(
                              onTap: () {
                                unFocus(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 4, 0, 8),
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.poppins(
                                              color: Colors.black),
                                          children: const [
                                            TextSpan(
                                              text: "Category",
                                            ),
                                            TextSpan(
                                              text: "*",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 4, 0, 8),
                                      child: CupertinoTextField(
                                        controller:
                                            Provider.of<AddPageViewModel>(
                                                    context,
                                                    listen: false)
                                                .categoryController,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(12, 0, 0, 8),
                                      child: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.poppins(
                                              color: Colors.black),
                                          children: const [
                                            TextSpan(
                                              text: "Cover",
                                            ),
                                            TextSpan(
                                              text: "*",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        viewModel.selectImage(context, "Cover");
                                      },
                                      child: Container(
                                        width: width,
                                        height: width / 2,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                              style: BorderStyle.solid,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: viewModel.coverImage != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                    viewModel.coverImage!),
                                              )
                                            : Center(
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(
                                                    fontSize: 50,
                                                    color: AppConstants
                                                        .secondaryColor,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (viewModel.categoryController.value
                                                  .text.isNotEmpty &&
                                              viewModel.coverImage != null) {
                                            viewModel.addNewCategory(
                                                viewModel.categoryController
                                                    .value.text,
                                                viewModel.coverImage!);
                                            Navigator.pop(context);
                                          } else {
                                            print(
                                                "Choose a cover image or type in category title!");
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                            (states) {
                                              if (viewModel.categoryController
                                                      .value.text.isNotEmpty &&
                                                  viewModel.coverImage !=
                                                      null) {
                                                return AppConstants
                                                    .secondaryColor!;
                                              } else {
                                                return Colors.grey[400]!;
                                              }
                                            },
                                          ),
                                        ),
                                        child: const Text(
                                          "Add",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).whenComplete(() {
                      Provider.of<AddPageViewModel>(
                        context,
                        listen: false,
                      ).coverImage = null;
                      Provider.of<AddPageViewModel>(
                        context,
                        listen: false,
                      ).categoryController.text = "";
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "New category? ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Color(0xffF24E1E),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 12,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Images",
                        ),
                        TextSpan(
                          text: "*",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                Carousel(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: CupertinoTextField(
                          controller: Provider.of<AddPageViewModel>(context,
                                  listen: false)
                              .priceController,
                          keyboardType: TextInputType.number,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const Text(
                        " \$",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 8,
              left: 8,
              child: SizedBox(
                width: width - 20,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppConstants.secondaryColor!),
                  ),
                  onPressed: () {
                    Provider.of<AddPageViewModel>(context, listen: false)
                        .addPoster(context: context);
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit and close"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
