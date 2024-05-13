import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';

class NewPostModalBottomSheet extends StatefulWidget {
  const NewPostModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<NewPostModalBottomSheet> createState() =>
      _NewPostModalBottomSheetState();
}

class _NewPostModalBottomSheetState extends State<NewPostModalBottomSheet> {
  final Color _foregroundColor = AppColors.gray3;
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  int remainingCount = 500;

  Future<void> _onPressedSend() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      await MastodonRepository.instance.postNewStatus(
        text: _controller.text,
        mediaIds: [],
        poll: [],
      );
    } catch (e) {
      throw Exception('Failed to send: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.gray1,
        border: Border(
          top: BorderSide(
            color: _foregroundColor,
          ),
        ),
      ),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'メッセージを入力',
              hintStyle: const TextStyle(color: AppColors.gray3),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _foregroundColor,
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                remainingCount = _controller.text.length;
              });
            },
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt_outlined),
                color: _foregroundColor,
              ),
              SizedBox(width: 8.w),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.image_outlined),
                color: _foregroundColor,
              ),
              const Spacer(),
              Text(
                '残り${500 - _controller.text.length}文字',
                style: TextStyle(color: _foregroundColor),
              ),
              IconButton(
                onPressed: _controller.text.isEmpty ? () {} : _onPressedSend,
                icon: const Icon(Icons.send),
                color: _controller.text.isEmpty
                    ? _foregroundColor
                    : AppColors.accent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
