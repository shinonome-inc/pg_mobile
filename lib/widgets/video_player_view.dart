import 'package:flutter/material.dart';
import 'package:pg_mobile/models/mastodon/media_attachment.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    Key? key,
    required this.mediaAttachments,
  }) : super(key: key);

  final List<MediaAttachment> mediaAttachments;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;
  bool _isLoading = false;

  Future<void> _initController() async {
    setState(() {
      _isLoading = true;
    });
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.mediaAttachments.first.url,
      ),
    );
    await _controller.initialize();
    await _controller.setLooping(true);
    await _controller.play();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () {
        NavigatorUtil.showNetworkVideoPreview(
          context: context,
          controller: _controller,
        );
      },
      child: VideoPlayer(_controller),
    );
  }
}
