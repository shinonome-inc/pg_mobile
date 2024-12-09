import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/extensions/build_context_extension.dart';

class TopView extends StatelessWidget {
  const TopView({
    super.key,
    required this.onTapSignIn,
  });

  final void Function() onTapSignIn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Text(
            'PGritへ\nようこそ！',
            style: context.textTheme.displaySmallBold,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onTapSignIn,
            child: Text(
              'ログイン',
              style: context.textTheme.bodyLargeBold,
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
