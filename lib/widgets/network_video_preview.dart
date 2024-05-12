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
  Duration _duration = const Duration();

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

  Future<void> _initialize() async {
    widget.controller.addListener(() async {
      final duration = await widget.controller.position;
      if (duration == null) return;
      setState(() {
        _duration = duration;
      });
      print(_duration.inMicroseconds);
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(
            widget.controller,
          ),
          SafeArea(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: CloseButton(),
                ),
                const Spacer(),
                Expanded(
                  child: IconButton(
                    onPressed: _onPressedPlayButton,
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    color: AppColors.white,
                  ),
                ),
                Slider(
                  value: _duration.inMicroseconds /
                      widget.controller.value.duration.inMicroseconds,
                  onChanged: (double value) {},
                  activeColor: AppColors.white,
                ),
                Row(
                  children: [
                    Text('${_duration.inMinutes}:${_duration.inSeconds}'),
                    const Spacer(),
                    Text('${_duration.inMinutes}:${_duration.inSeconds}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
