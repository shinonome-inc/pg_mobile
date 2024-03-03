import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pg_mobile/constants/app_colors.dart';

class DebugMediaPage extends StatefulWidget {
  const DebugMediaPage({Key? key}) : super(key: key);

  @override
  State<DebugMediaPage> createState() => _DebugMediaPageState();
}

class _DebugMediaPageState extends State<DebugMediaPage> {
  bool _isLoading = false;
  final List<XFile?> _files = [];

  final _picker = ImagePicker();
  final int maxMediaCount = 4;

  bool get _isFullMediaCount => _files.length >= maxMediaCount;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  Future<void> _onPressedGallery() async {
    if (_isLoading) return;
    _setLoading(true);
    final files = await _picker.pickMultipleMedia();
    if (files.isEmpty) {
      _setLoading(false);
      return;
    }
    setState(() {
      _files.addAll(files);
    });
    _setLoading(false);
  }

  Future<void> _onPressedCamera() async {
    if (_isLoading) return;
    _setLoading(true);
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
    setState(() {
      _files.removeAt(index);
    });
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
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: 120.h,
                                decoration: BoxDecoration(
                                  color: AppColors.gray2,
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(_files[index]!.path),
                                    ),
                                  ),
                                ),
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
                onPressed: _isFullMediaCount ? null : _onPressedCamera,
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
                onPressed: _isFullMediaCount ? null : _onPressedGallery,
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
