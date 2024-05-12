import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoThumbnailView extends StatefulWidget {
  const NetworkVideoThumbnailView({
    Key? key,
    required this.url,
    this.isGifv = false,
  }) : super(key: key);

  final String url;
  final bool isGifv;

  @override
  State<NetworkVideoThumbnailView> createState() =>
      _NetworkVideoThumbnailViewState();
}

class _NetworkVideoThumbnailViewState extends State<NetworkVideoThumbnailView> {
  late VideoPlayerController _controller;
  bool _isLoading = false;

  Future<void> _initController() async {
    setState(() {
      _isLoading = true;
    });
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
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
        if (widget.isGifv) {
          NavigatorUtil.showNetworkGifvPreview(
            context: context,
            controller: _controller,
          );
        } else {
          NavigatorUtil.showNetworkVideoPreview(
            context: context,
            controller: _controller,
          );
        }
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          VideoPlayer(_controller),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
            margin: EdgeInsets.only(left: 4.w, bottom: 4.h),
            decoration: BoxDecoration(
              color: AppColors.gray1A80,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Text(
              'GIF',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
