import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({Key? key}) : super(key: key);

  Widget _button(String text, {required Function() onPressed}) {
    return Column(
      children: [
        SizedBox(height: 64.h),
        SizedBox(
          height: 40.h,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(text),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "debugページ",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _button("サインイン画面", onPressed: () {}),
          _button("タイムライン画面", onPressed: () {}),
          _button("通知画面", onPressed: () {}),
        ],
      ),
    );
  }
}
