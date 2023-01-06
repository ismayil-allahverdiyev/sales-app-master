import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/addPage/view_model/add_page_view_model.dart';
import 'package:sales_app/features/product/services/poster_service.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';

class AddPageView extends StatelessWidget {
  const AddPageView({super.key});

  @override
  Widget build(BuildContext context) {
    PosterService posterService = PosterService();
    posterService.getAllPosters(context: context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Sthh"),
      ),
      body: ListView(
        children: [
          TextField(
            controller: Provider.of<AddPageViewModel>(context, listen: false)
                .titleController,
          ),
          TextField(
            controller: Provider.of<AddPageViewModel>(context, listen: false)
                .categorieController,
          ),
          TextField(
            controller: Provider.of<AddPageViewModel>(context, listen: false)
                .priceController,
            keyboardType: TextInputType.number,
          ),
          IconButton(
            onPressed: () {
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
                  userId: Provider.of<UserInfoViewModel>(context, listen: false)
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
    );
  }
}
