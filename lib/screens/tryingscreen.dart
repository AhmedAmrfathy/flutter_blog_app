import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TryingScreen extends StatefulWidget {
  @override
  _TryingScreenState createState() => _TryingScreenState();
}

class _TryingScreenState extends State<TryingScreen> {
  VideoPlayerController videoPlayerController;
  VoidCallback listener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  void createvdio() {
    if (videoPlayerController == null) {
      videoPlayerController = VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        ..addListener(listener)
        ..setVolume(1.0)
        ..setLooping(true)
        ..initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
                child: videoPlayerController != null
                    ? VideoPlayer(videoPlayerController)
                    : Container()),
          ),
        ),
        RaisedButton(
          onPressed: () {
            createvdio();
            videoPlayerController.play();
          },
        ),
      ],
    );
  }
}
