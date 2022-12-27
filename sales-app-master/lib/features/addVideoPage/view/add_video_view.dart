import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../addPage/view_model/add_page_view_model.dart';
import '../../product/services/poster_service.dart';
import '../../sign_page/view_model/user_info_view_model.dart';

class AddVideoView extends StatefulWidget {
  const AddVideoView({super.key});

  @override
  State<AddVideoView> createState() => _AddVideoViewState();
}

class _AddVideoViewState extends State<AddVideoView> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    PosterService posterService = PosterService();
    posterService.getAllPosters(context: context);

    @override
    void initState() {
      _controller = VideoPlayerController.network(
          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
      //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
      _initializeVideoPlayerFuture = _controller!.initialize();
      _controller!.setLooping(true);
      _controller!.setVolume(1.0);
      super.initState();
    }

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
              posterService.addPoster(
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
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          IconButton(
            onPressed: () {
              posterService.getVideoPoster(filename: "filename");
            },
            icon: Icon(Icons.access_alarm),
          ),
        ],
      ),
    );
  }
}
