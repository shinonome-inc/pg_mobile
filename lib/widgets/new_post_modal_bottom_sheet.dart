import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';

class NewPostModalBottomSheet extends StatelessWidget {
  const NewPostModalBottomSheet({Key? key}) : super(key: key);

  final Color _foregroundColor = AppColors.gray3;

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
                '残りxxx文字',
                style: TextStyle(color: _foregroundColor),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
                color: AppColors.accent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
