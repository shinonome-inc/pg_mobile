import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPreview extends StatefulWidget {
  const NetworkVideoPreview({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoPlayerController controller;

  @override
  State<NetworkVideoPreview> createState() => _NetworkVideoPreviewState();
}

class _NetworkVideoPreviewState extends State<NetworkVideoPreview> {
  late FlickManager _flickManager;

  Future<void> _onPressedClose() async {
    await widget.controller.setLooping(true);
    await widget.controller.play();
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  @override
  void initState() {
    super.initState();
    widget.controller.setLooping(false);
    _flickManager = FlickManager(
      videoPlayerController: widget.controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlickVideoPlayer(
          flickManager: _flickManager,
        ),
        SafeArea(
          child: CloseButton(
            onPressed: _onPressedClose,
          ),
        ),
      ],
    );
  }
}
