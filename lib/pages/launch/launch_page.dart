import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:pg_mobile/pages/launch/launch_notifier.dart';

class LaunchPage extends ConsumerStatefulWidget {
  const LaunchPage({super.key});

  @override
  ConsumerState createState() => _LaunchPageState();
}

class _LaunchPageState extends ConsumerState<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(launchNotifierProvider);
    final hasData = asyncState.hasValue && asyncState.value != null;
    if (hasData) {
      final state = asyncState.value!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(
          state.isSignedIn ? AppPage.timeline.path : AppPage.top.path,
        );
      });
    }
    return const Scaffold(
      body: Center(
        child: Text('Launch Page'),
      ),
    );
  }
}
