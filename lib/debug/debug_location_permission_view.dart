import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/debug/debug_location_notifier.dart';

class DebugLocationPermissionView extends ConsumerWidget {
  const DebugLocationPermissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(debugLocationProvider.notifier);
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
              onPressed: notifier.openSettings,
              child: const Text('設定を開く'),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
