import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/debug/location/debug_location_notifier.dart';
import 'package:pg_mobile/extensions/target_platform_extension.dart';

class DebugLocationPermissionView extends ConsumerWidget {
  const DebugLocationPermissionView({Key? key}) : super(key: key);

  // FIXME: iOSだと設定にこのアプリが表示されないので他の権限周りの技術調査時に修正する。
  Future<void> _onTapSettings(BuildContext context) async {
    if (Theme.of(context).platform.isIOS) {
      await Permission.locationAlways.request();
    } else {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(debugLocationProvider.notifier);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'オフィス機能を利用するには、',
                ),
                TextSpan(
                  text: ' 本体設定 ',
                  style: const TextStyle(
                    color: AppColors.accent,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _onTapSettings(context),
                ),
                const TextSpan(
                  text: 'から位置情報へのアクセスを許可し、再読み込みを行ってください。',
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: notifier.reload,
              child: const Text('再読み込み'),
            ),
          ),
          SizedBox(height: 64.h),
        ],
      ),
    );
  }
}
