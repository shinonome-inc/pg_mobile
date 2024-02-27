import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/debug/debug_loding_view.dart';
import 'package:pg_mobile/debug/location/debug_location_notifier.dart';
import 'package:pg_mobile/debug/location/debug_location_permission_view.dart';
import 'package:pg_mobile/debug/location/debug_location_view.dart';
import 'package:pg_mobile/extensions/permission_status_extension.dart';

class DebugLocationPage extends ConsumerStatefulWidget {
  const DebugLocationPage({super.key});

  @override
  DebugLocationPageState createState() => DebugLocationPageState();
}

class DebugLocationPageState extends ConsumerState<DebugLocationPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(debugLocationProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('位置情報'),
          ),
          body: state.status.isGranted
              ? const DebugLocationView()
              : const DebugLocationPermissionView(),
        ),
        if (state.isLoading) const DebugLoadingView()
      ],
    );
  }
}
