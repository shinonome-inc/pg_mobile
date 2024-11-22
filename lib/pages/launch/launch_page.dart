import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/config/router.dart';
import 'package:pg_mobile/pages/launch/launch_notifier.dart';

class LaunchPage extends ConsumerStatefulWidget {
  const LaunchPage({super.key});

  @override
  ConsumerState createState() => _LaunchPageState();
}

class _LaunchPageState extends ConsumerState<LaunchPage> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      final notifier = ref.read(launchNotifierProvider.notifier);
      final isSignedIn = await notifier.isSignedIn();
      if (!mounted) return;
      if (isSignedIn) {
        context.go(AppPage.statusList.path);
        return;
      }
      context.go(AppPage.top.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Launch Page'),
      ),
    );
  }
}
