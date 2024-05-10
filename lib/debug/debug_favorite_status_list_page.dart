import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/providers/favorite_status_list_notifier.dart';
import 'package:pg_mobile/widgets/status_view.dart';

class DebugFavoriteStatusListPage extends ConsumerStatefulWidget {
  const DebugFavoriteStatusListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DebugFavoriteStatusListPage> createState() =>
      _DebugFavoriteStatusListPageState();
}

class _DebugFavoriteStatusListPageState
    extends ConsumerState<DebugFavoriteStatusListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        await ref
            .read(favoriteStatusListProvider.notifier)
            .fetchFavoriteStatusList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteStatusList = ref.watch(
      favoriteStatusListProvider.select((value) => value.favoriteStatusList),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入り一覧画面'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: favoriteStatusList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == favoriteStatusList.length) {
            return const Center(
              child: CupertinoActivityIndicator(color: AppColors.white),
            );
          }
          return StatusView(status: favoriteStatusList[index]);
        },
      ),
    );
  }
}
