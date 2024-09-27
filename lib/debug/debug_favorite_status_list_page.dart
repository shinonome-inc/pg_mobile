import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/providers/favorite_status_list_notifier.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/widgets/status_item.dart';

class DebugFavoriteStatusListPage extends ConsumerStatefulWidget {
  const DebugFavoriteStatusListPage({super.key});

  @override
  ConsumerState<DebugFavoriteStatusListPage> createState() =>
      _DebugFavoriteStatusListPageState();
}

class _DebugFavoriteStatusListPageState
    extends ConsumerState<DebugFavoriteStatusListPage> {
  final ScrollController _scrollController = ScrollController();
  Account signedInUser = initialAccount;

  Future<void> _fetchedSignedInUser() async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    notifier.setLoading(true);
    setState(() async {
      signedInUser = await MastodonRepository.instance.fetchCredentialAccount();
    });
    notifier.setLoading(false);
  }

  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        await ref
            .read(favoriteStatusListNotifierProvider.notifier)
            .fetchFavoriteStatusList();
      }
    });
    _fetchedSignedInUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statuses = ref.watch(
      favoriteStatusListNotifierProvider
          .select((value) => value.favoriteStatusList),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入り一覧画面'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: statuses.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == statuses.length) {
            return const Center(
              child: CupertinoActivityIndicator(color: AppColors.white),
            );
          }
          return StatusItem(
            status: statuses[index],
          );
        },
      ),
    );
  }
}
