import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/models/enums/app_page.dart';

class HashTagPage extends ConsumerStatefulWidget {
  const HashTagPage({super.key});

  @override
  ConsumerState createState() => _HashTagPageState();
}

class _HashTagPageState extends ConsumerState<HashTagPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hash Tag Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              context.push(AppPage.user.path);
            },
            child: const Text('User'),
          ),
          TextButton(
            onPressed: () {
              context.push(AppPage.hashTag.path);
            },
            child: const Text('Hash Tag'),
          ),
          TextButton(
            onPressed: () {
              context.push(AppPage.user.path);
            },
            child: const Text('Status Detail'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(AppPage.createStatus.path);
        },
      ),
    );
  }
}
