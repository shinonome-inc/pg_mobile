import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/providers/favorite_user_list_notifier.dart';
import 'package:pg_mobile/widgets/favorite_user_item.dart';

class DebugFavoriteUserListPage extends ConsumerStatefulWidget {
  const DebugFavoriteUserListPage({required this.statusId, super.key});
  final String statusId;

  @override
  ConsumerState<DebugFavoriteUserListPage> createState() =>
      _DebugFavoriteUserListPageState();
}

class _DebugFavoriteUserListPageState
    extends ConsumerState<DebugFavoriteUserListPage> {
  @override
  void initState() {
    super.initState();
    // ボタンを押したら、すぐに画面遷移できるようにinitStateでAPIからデータを取得
    Future(() async {
      await ref
          .read(favoriteUserListProvider.notifier)
          .fetchFavoriteUserList(widget.statusId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteUserAccountList = ref.watch(
      favoriteUserListProvider.select((value) => value.favoriteUserAccountList),
    );
    final isLoading =
        ref.watch(favoriteUserListProvider.select((value) => value.isLoading));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: isLoading && favoriteUserAccountList.isEmpty
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView.builder(
              itemCount: favoriteUserAccountList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    FavoriteUserItem(
                      account: favoriteUserAccountList[index],
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                      color: AppColors.gray2,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
