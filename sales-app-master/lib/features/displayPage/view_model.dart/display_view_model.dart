import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class DisplayViewModel extends ChangeNotifier {
  DisplayViewModel() {
    controller.initialize();
    controller.play();
    controller.setLooping(true);
  }
  VideoPlayerController controller = VideoPlayerController.network(
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  );
}
