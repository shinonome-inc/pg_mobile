import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DebugLocationPermissionView extends StatelessWidget {
  const DebugLocationPermissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const Spacer(),
          const Text(
            'オフィス機能を利用するには、このアプリが位置情報にアクセスするのを許可する必要があります。',
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('設定を開く'),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
