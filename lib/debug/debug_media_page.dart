import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/extensions/x_file_extension.dart';
import 'package:video_player/video_player.dart';

class DebugMediaPage extends StatefulWidget {
  const DebugMediaPage({Key? key}) : super(key: key);

  @override
  State<DebugMediaPage> createState() => _DebugMediaPageState();
}

class _DebugMediaPageState extends State<DebugMediaPage> {
  bool _isLoading = false;
  bool _hasSelectVideo = false;
  final List<XFile?> _files = [];

  final _picker = ImagePicker();
  VideoPlayerController _videoController = VideoPlayerController.asset('');

  final int maxSelectedMediaCount = 4;

  bool get _isFullSelectedMediaCount => _files.length >= maxSelectedMediaCount;
  bool get _disableAddMedia => _isFullSelectedMediaCount || _hasSelectVideo;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _setSelectVideo(bool value) {
    setState(() {
      _hasSelectVideo = value;
    });
  }

  void _setVideo(XFile file) {
    _videoController = VideoPlayerController.file(
      File(file.path),
    )..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  void _removeSelectedVideo() {
    _videoController = VideoPlayerController.asset('')
      ..initialize().then((_) => setState(() {}));
    _setSelectVideo(false);
  }

  Future<void> _onPressedGallery() async {
    if (_isLoading) return;
    _setLoading(true);
    final status = await Permission.photos.request();
    if (!status.isGranted) {
      // TODO: アラートダイアログを表示
      await openAppSettings();
      _setLoading(false);
      return;
    }
    List<XFile?> pickedFiles = await _picker.pickMultipleMedia();
    if (pickedFiles.isEmpty) {
      _setLoading(false);
      return;
    }
    for (final file in pickedFiles) {
      if (file == null || _disableAddMedia) {
        continue;
      } else if (file.isVideo && _files.isEmpty) {
        setState(() {
          _files.add(file);
        });
        _setVideo(file);
        _setSelectVideo(true);
      } else if (file.isImage) {
        setState(() {
          _files.add(file);
        });
      }
    }
    _setLoading(false);
  }

  Future<void> _onPressedCamera() async {
    if (_isLoading) return;
    _setLoading(true);
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      // TODO: アラートダイアログを表示
      await openAppSettings();
      _setLoading(false);
      return;
    }
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      _setLoading(false);
      return;
    }
    setState(() {
      _files.add(image);
    });
    _setLoading(false);
  }

  void _removeMedia(int index) {
    final file = _files[index];
    if (file == null) {
      return;
    } else if (file.isVideo) {
      _removeSelectedVideo();
    }
    setState(() {
      _files.removeAt(index);
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const Spacer(),
              _files.isEmpty
                  ? const Text('画像・動画が選択されていません')
                  : SizedBox(
                      height: 120.h,
                      child: ListView.builder(
                        itemCount: _files.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final file = _files[index];
                          if (file == null) {
                            return const SizedBox.shrink();
                          }
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: 120.h,
                                color: AppColors.gray2,
                                child: file.isImage
                                    ? Image(
                                        image: FileImage(
                                          File(file.path),
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : file.isVideo
                                        ? VideoPlayer(_videoController)
                                        : const SizedBox.shrink(),
                              ),
                              IconButton(
                                onPressed: () => _removeMedia(index),
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.gray1A80,
                                ),
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
              const Spacer(),
              ElevatedButton(
                onPressed: _disableAddMedia ? null : _onPressedCamera,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt_outlined),
                    SizedBox(width: 8.w),
                    const Text('カメラから画像を追加する'),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: _disableAddMedia ? null : _onPressedGallery,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.image_outlined),
                    SizedBox(width: 8.w),
                    const Text('アルバムから画像を追加する'),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
