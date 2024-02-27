import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/locations.dart';
import 'package:pg_mobile/debug/location/debug_location_notifier.dart';
import 'package:pg_mobile/debug/location/debug_location_state.dart';

class DebugLocationView extends ConsumerStatefulWidget {
  const DebugLocationView({super.key});

  @override
  DebugLocationViewState createState() => DebugLocationViewState();
}

class DebugLocationViewState extends ConsumerState<DebugLocationView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(debugLocationProvider);
    final notifier = ref.read(debugLocationProvider.notifier);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'オフィスの座標: ${Locations.debugTargetLat.toStringAsFixed(5)}, ${Locations.debugTargetLong.toStringAsFixed(5)}',
          ),
          Text(
            '　現在地の座標: ${state.currentLat.toStringAsFixed(5)}, ${state.currentLong.toStringAsFixed(5)}',
          ),
          const Divider(),
          Text('オフィスまでの距離: ${state.distanceInMeters.toStringAsFixed(2)}(m)'),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  state.enableCheckInButton ? notifier.checkInCheckOut : null,
              child: Text(state.isCheckingIn ? 'チェックアウト' : 'チェックイン'),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
