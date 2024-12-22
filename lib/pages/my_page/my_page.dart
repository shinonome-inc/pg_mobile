import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/pages/my_page/my_page_notifier.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/widgets/media_grid_view_item.dart';
import 'package:pg_mobile/widgets/status/status.dart';
import 'package:pg_mobile/widgets/user/user_profile_view.dart';

enum _TabMenu {
  post,
  reply,
  media;

  String get _text {
    switch (this) {
      case _TabMenu.post:
        return '投稿';
      case _TabMenu.reply:
        return '返信';
      case _TabMenu.media:
        return 'メディア';
    }
  }
}

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  void _onTapStatusCount() {
    context.push(AppPage.timeline.path);
  }

  void _onTapFollowingCount() {
    context.push(AppPage.followingList.path);
  }

  void _onTapFollowerCount() {
    context.push(AppPage.followerList.path);
  }

  Future<void> _onRefresh() async {
    await ref.read(myPageNotifierProvider.notifier).fetchMyPageInfo();
  }

  Future<void> _onTapPinStatus(Status status) async {
    final notifier = ref.read(myPageNotifierProvider.notifier);
    await notifier.pinStatus(status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(myPageNotifierProvider.notifier).fetchMyPageInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final signedInUser = ref.watch(signedInUserNotifierProvider);
    final state = ref.watch(myPageNotifierProvider);
    final notifier = ref.read(myPageNotifierProvider.notifier);
    if (signedInUser == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: DefaultTabController(
        length: _TabMenu.values.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    UserProfileView(
                      user: signedInUser,
                      onTapStatusCount: _onTapStatusCount,
                      onTapFollowingCount: _onTapFollowingCount,
                      onTapFollowerCount: _onTapFollowerCount,
                    ),
                    SizedBox(height: 16.h),
                    TabBar(
                      tabs: <Widget>[
                        for (final menu in _TabMenu.values)
                          Tab(text: menu._text),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.statusesWithoutReply.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final status = state.statusesWithoutReply.elementAt(index);
                    return StatusItem(
                      status: status,
                      signedInUser: signedInUser,
                      onTapBoost: () => notifier.boost(status),
                      onTapFavorite: () => notifier.favoriteStatus(status),
                      onPinStatus: () => _onTapPinStatus(status),
                      onDeleteAndReturnToDraft: () {},
                      onDelete: () {},
                      onMute: () {},
                      onBlock: () {},
                    );
                  },
                ),
              ),
              RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.statusesWithReply.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final status = state.statusesWithReply.elementAt(index);
                    return StatusItem(
                      status: status,
                      signedInUser: signedInUser,
                      onTapBoost: () => notifier.boost(status),
                      onTapFavorite: () => notifier.favoriteStatus(status),
                      onPinStatus: () => _onTapPinStatus(status),
                      onDeleteAndReturnToDraft: () {},
                      onDelete: () {},
                      onMute: () {},
                      onBlock: () {},
                    );
                  },
                ),
              ),
              RefreshIndicator(
                onRefresh: _onRefresh,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.mediaStatuses.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4.h,
                    crossAxisSpacing: 4.h,
                  ),
                  itemBuilder: (context, index) {
                    final status = state.mediaStatuses.elementAt(index);
                    return MediaGridViewItem(
                      status: status,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
