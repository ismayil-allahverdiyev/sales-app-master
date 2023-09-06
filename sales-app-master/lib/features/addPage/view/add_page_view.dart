import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/addPage/view/carousel.dart';
import 'package:sales_app/features/addPage/view_model/add_page_view_model.dart';
import 'package:sales_app/features/addPage/widgets/category_add_button.dart';

import '../widgets/category_selection_widget.dart';
import '../widgets/title_text_field.dart';

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
            onPopPage(context);
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Text(
                    "Title",
                  ),
                ),
                const TitleTextField(),
                const CategorySelectionWidget(),
                const CategoryAddButton(),
                const SizedBox(
                  height: 8,
                ),
                const CustomTitleWidget(title: "Images"),
                const Carousel(),
                const CustomTitleWidget(title: "Color Palette"),
                Consumer<AddPageViewModel>(builder: (context, viewModel, _) {
                  return Stack(
                    children: [
                      ColorPicker(
                        color: viewModel.currentChosenColor == null
                            ? Colors.red
                            : viewModel.currentChosenColor!,
                        onColorChanged: (value) {
                          viewModel.currentChosenColor = value;
                          String title = colorNameConverter(value);
                          viewModel.currentChosenColorName = title;
                        },
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.addColorToTheList();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => AppConstants.secondaryColor!,
                            ),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  );
                }),
                Consumer<AddPageViewModel>(
                  builder: (context, viewModel, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.colorPaletteWidgetList.length,
                      itemBuilder: (context, index) {
                        return viewModel.colorPaletteWidgetList[index];
                      },
                    );
                  },
                ),
                const CustomTitleWidget(title: "Price"),
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
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 8,
              left: 8,
              child: SubmitButton(width: width),
            )
          ],
        ),
      ),
    );
  }

  String colorNameConverter(Color value) {
    List<String> list = ColorTools.materialName(value).split(" ");
    list =
        ColorTools.materialName(value).split(" ").sublist(0, list.length - 1);
    String title = "";
    for (int i = 0; i < list.length; i++) {
      title += list[i];
      print(list[i]);
      title += " ";
    }
    return title;
  }

  void onPopPage(BuildContext context) {
    Provider.of<AddPageViewModel>(context, listen: false).emptyPage(context);
    Navigator.pop(context);
  }
}

class CustomTitleWidget extends StatelessWidget {
  const CustomTitleWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(color: Colors.black),
          children: [
            TextSpan(
              text: title,
            ),
            const TextSpan(
              text: "*",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width - 20,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => AppConstants.secondaryColor!),
        ),
        onPressed: () {
          if (Provider.of<AddPageViewModel>(context, listen: false)
              .checkIfReady(context)) {
            Provider.of<AddPageViewModel>(context, listen: false)
                .addPoster(context: context);
            Provider.of<AddPageViewModel>(context, listen: false)
                .emptyPage(context);
            Navigator.of(context).pop();
          } else {
            print("Not ready");
          }
        },
        child: Text("Submit and close"),
      ),
    );
  }
}
