import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../view_model/add_page_view_model.dart';

class CategoryAddButton extends StatelessWidget {
  const CategoryAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<AddPageViewModel>(builder: (context, viewModel, _) {
      return GestureDetector(
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
                builder: (context, viewModel, child) => SizedBox(
                  height: MediaQuery.of(context).size.height / 4 * 3,
                  child: Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: MediaQuery.of(context).viewInsets,
                    child: GestureDetector(
                      onTap: () {
                        unFocus(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 4, 0, 8),
                              child: RichText(
                                text: TextSpan(
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
                                  children: const [
                                    TextSpan(
                                      text: "Category",
                                    ),
                                    TextSpan(
                                      text: "*",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                              child: CupertinoTextField(
                                controller: viewModel.categoryController,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 0, 0, 8),
                              child: RichText(
                                text: TextSpan(
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
                                  children: const [
                                    TextSpan(
                                      text: "Cover",
                                    ),
                                    TextSpan(
                                      text: "*",
                                      style: TextStyle(color: Colors.red),
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
                                height: width / 3 * 4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                child: viewModel.coverImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          viewModel.coverImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                            fontSize: 50,
                                            color: AppConstants.secondaryColor,
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
                                  if (viewModel.categoryController.value.text
                                          .isNotEmpty &&
                                      viewModel.coverImage != null) {
                                    viewModel.addNewCategory(
                                        viewModel.categoryController.value.text,
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
                                      if (viewModel.categoryController.value
                                              .text.isNotEmpty &&
                                          viewModel.coverImage != null) {
                                        return AppConstants.secondaryColor!;
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
                ),
              );
            },
          ).whenComplete(() {
            viewModel.coverImage = null;
            viewModel.categoryController.text = "";
          });
        },
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            const Text(
              "New category? ",
              style: TextStyle(fontSize: 12),
            ),
            viewModel.menuItemsLoading == true
                ? const Row(
                    children: [
                      SizedBox(
                        height: 12,
                        width: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xffF24E1E),
                        ),
                      ),
                      Text(
                        " Loading...",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color(0xffF24E1E),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
            const SizedBox(
              width: 4,
            ),
          ],
        ),
      );
    });
  }
}
