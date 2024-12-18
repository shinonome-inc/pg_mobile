import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/extensions/build_context_extension.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:pg_mobile/pages/my_page/my_page_notifier.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
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
    context.go(AppPage.timeline.path);
  }

  void _onTapFollowingCount() {
    context.go(AppPage.followingList.path);
  }

  void _onTapFollowerCount() {
    context.go(AppPage.followerList.path);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(myPageNotifierProvider.notifier).fetchStatuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(signedInUserNotifierProvider);
    final state = ref.watch(myPageNotifierProvider);
    if (user == null) {
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
                      user: user,
                      onTapStatusCount: _onTapStatusCount,
                      onTapFollowingCount: _onTapFollowingCount,
                      onTapFollowerCount: _onTapFollowerCount,
                    ),
                    SizedBox(height: 16.h),
                    TabBar(
                      labelStyle: context.textTheme.bodyMediumBold,
                      unselectedLabelStyle: context.textTheme.bodyMediumNormal,
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
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.statuses.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return StatusItem(
                    status: state.statuses.elementAt(index),
                    onTapItem: () {},
                    onTapAccount: () {},
                    onTapHashtag: () {},
                    onTapMention: () {},
                    onTapReply: () {},
                    onTapBoost: () {},
                    onTapFavorite: () {},
                    onTapMenu: () {},
                    onCopyLink: () {},
                    onPinToProfile: () {},
                    onUnpinToProfile: () {},
                    onDeleteAndReturnToDraft: () {},
                    onDelete: () {},
                    onMute: () {},
                    onBlock: () {},
                    onCancel: () {},
                  );
                },
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.statuses.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return StatusItem(
                    status: state.statuses.elementAt(index),
                    onTapItem: () {},
                    onTapAccount: () {},
                    onTapHashtag: () {},
                    onTapMention: () {},
                    onTapReply: () {},
                    onTapBoost: () {},
                    onTapFavorite: () {},
                    onTapMenu: () {},
                    onCopyLink: () {},
                    onPinToProfile: () {},
                    onUnpinToProfile: () {},
                    onDeleteAndReturnToDraft: () {},
                    onDelete: () {},
                    onMute: () {},
                    onBlock: () {},
                    onCancel: () {},
                  );
                },
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.statuses.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return StatusItem(
                    status: state.statuses.elementAt(index),
                    onTapItem: () {},
                    onTapAccount: () {},
                    onTapHashtag: () {},
                    onTapMention: () {},
                    onTapReply: () {},
                    onTapBoost: () {},
                    onTapFavorite: () {},
                    onTapMenu: () {},
                    onCopyLink: () {},
                    onPinToProfile: () {},
                    onUnpinToProfile: () {},
                    onDeleteAndReturnToDraft: () {},
                    onDelete: () {},
                    onMute: () {},
                    onBlock: () {},
                    onCancel: () {},
                  );
                },
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
