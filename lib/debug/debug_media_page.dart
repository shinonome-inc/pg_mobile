import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class DebugMediaPage extends StatefulWidget {
  const DebugMediaPage({Key? key}) : super(key: key);

  @override
  State<DebugMediaPage> createState() => _DebugMediaPageState();
}

class _DebugMediaPageState extends State<DebugMediaPage> {
  bool _isLoading = false;
  List<XFile?> _files = [];

  final _picker = ImagePicker();
  final int maxMediaCount = 4;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  Future<void> _onPressedGallery() async {
    if (_isLoading) return;
    if (_files.length >= maxMediaCount) return;
    _setLoading(true);
    final files = await _picker.pickMultipleMedia();
    if (files.isEmpty) {
      _setLoading(false);
      return;
    }
    setState(() {
      _files = files;
    });
    _setLoading(false);
  }

  Future<void> _onPressedCamera() async {
    if (_isLoading) return;
    if (_files.length >= maxMediaCount) return;
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
              if (_files.isEmpty) const Text('画像・動画が選択されていません'),
              const Spacer(),
              ElevatedButton(
                onPressed: _onPressedCamera,
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
                onPressed: _onPressedGallery,
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
