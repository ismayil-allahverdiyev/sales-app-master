import 'package:flutter/cupertino.dart';
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
      body: ListView(
        children: [
          Icon(Icons.arrow_back),
          Text("Title"),
          CupertinoTextField(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: Colors.grey[300]!, style: BorderStyle.solid, width: 2),
            ),
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
