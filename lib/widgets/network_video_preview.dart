import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';
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
  bool _isLoading = false;
  bool _isPlaying = true;

  Future<void> _onPressedPlayButton() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      if (_isPlaying) {
        await widget.controller.pause();
      } else {
        await widget.controller.play();
      }
    } catch (e) {
      throw Exception('Failed to play or pause video: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(
              widget.controller,
            ),
            IconButton(
              onPressed: _onPressedPlayButton,
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              color: AppColors.white,
            ),
          ],
        ),
        const SafeArea(
          child: CloseButton(),
        ),
      ],
    );
  }
}
