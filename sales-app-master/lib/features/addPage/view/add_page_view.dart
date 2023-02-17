import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/addPage/view/carousel.dart';
import 'package:sales_app/features/addPage/view_model/add_page_view_model.dart';
import 'package:sales_app/features/product/services/poster_service.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';

class AddPageView extends StatelessWidget {
  const AddPageView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PosterService posterService = PosterService();

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
        child: ListView(
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
                child: DropdownButtonFormField(
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
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text("AAA"),
                    )
                  ],
                  onChanged: (value) {},
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return Center(
                      child: Container(
                        height: width / 2,
                        width: width - 50,
                        color: Colors.white,
                      ),
                    );
                  },
                );
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
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            //   child: CupertinoTextField(
            //     controller:
            //         Provider.of<AddPageViewModel>(context, listen: false)
            //             .categorieController,
            //     padding: EdgeInsets.all(8),
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         color: Colors.grey[300]!,
            //       ),
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(6),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 3,
                    child: CupertinoTextField(
                      controller:
                          Provider.of<AddPageViewModel>(context, listen: false)
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
            IconButton(
              onPressed: () {
                print(
                  Provider.of<AddPageViewModel>(context, listen: false)
                      .titleController
                      .text,
                );
                print(
                  Provider.of<AddPageViewModel>(context, listen: false)
                      .categorieController
                      .text,
                );
                print(
                  Provider.of<AddPageViewModel>(context, listen: false)
                      .priceController
                      .text,
                );
                print(
                  Provider.of<UserInfoViewModel>(context, listen: false)
                      .user
                      .id,
                );
                print(
                  Provider.of<AddPageViewModel>(context, listen: false)
                      .nFile!
                      .path,
                );
                posterService.addVideoPoster(
                    context: context,
                    title: Provider.of<AddPageViewModel>(context, listen: false)
                        .titleController
                        .text,
                    categorie:
                        Provider.of<AddPageViewModel>(context, listen: false)
                            .categorieController
                            .text,
                    price: double.parse(
                        Provider.of<AddPageViewModel>(context, listen: false)
                            .priceController
                            .text),
                    userId:
                        Provider.of<UserInfoViewModel>(context, listen: false)
                            .user
                            .id,
                    file: Provider.of<AddPageViewModel>(context, listen: false)
                        .nFile!);
              },
              icon: Icon(Icons.radar_outlined),
            ),
            IconButton(
              onPressed: () {
                posterService.getAllPosters(context: context);
              },
              icon: Icon(Icons.send),
            ),
            IconButton(
              onPressed: () async {
                Provider.of<AddPageViewModel>(context, listen: false)
                    .pickImage(context);
              },
              icon: Icon(
                Icons.image,
              ),
            ),
            IconButton(
              onPressed: () {
                print("Path is " +
                    Provider.of<AddPageViewModel>(context, listen: false)
                        .imageFile
                        .path);
              },
              icon: Icon(Icons.upload),
            ),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  style: BorderStyle.solid,
                  width: 3,
                ),
              ),
              child: Provider.of<AddPageViewModel>(context).nFile != null
                  ? Image.file(Provider.of<AddPageViewModel>(context).nFile!)
                  : Text("S"),
            )
          ],
        ),
      ),
    );
  }
}
