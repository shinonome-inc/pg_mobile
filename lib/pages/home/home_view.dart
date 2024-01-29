import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/debug/debug_page.dart';
import 'package:pg_mobile/pages/post/post.view.dart';
import 'package:pg_mobile/pages/user/user_view.dart';
import 'package:pg_mobile/util.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('Home'),
              TextButton(
                onPressed: () {
                  Util.showBottomSheetMenu(context, const UserView());
                },
                child: const Text('User'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  Util.pushScreen(context, const DebugPage());
                },
                child: const Text('Debug'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Util.showBottomSheetMenu(context, const PostView());
          },
          child: const Icon(Icons.add),
        ));
  }
}
