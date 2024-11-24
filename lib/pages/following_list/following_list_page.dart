import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/models/enums/app_page.dart';

class FollowingListPage extends ConsumerStatefulWidget {
  const FollowingListPage({super.key});

  @override
  ConsumerState createState() => _FollowingListPageState();
}

class _FollowingListPageState extends ConsumerState<FollowingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following List Page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.push(AppPage.user.path);
          },
          child: const Text('User'),
        ),
      ),
    );
  }
}
