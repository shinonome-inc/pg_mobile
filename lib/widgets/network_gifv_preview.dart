import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NetworkGifvPreview extends StatefulWidget {
  const NetworkGifvPreview({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoPlayerController controller;

  @override
  State<NetworkGifvPreview> createState() => _NetworkGifvPreviewState();
}

class _NetworkGifvPreviewState extends State<NetworkGifvPreview> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 5,
              child: VideoPlayer(widget.controller),
            ),
          ),
        ),
        const SafeArea(
          child: CloseButton(),
        ),
      ],
    );
  }
}
