import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/extensions/status_extension.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/mastodon/status_menu_action.dart';
import 'package:pg_mobile/pages/timeline/timeline_notifier.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/util/status_menu_action_util.dart';
import 'package:pg_mobile/widgets/status/status_item.dart';

class TimelinePage extends ConsumerStatefulWidget {
  const TimelinePage({super.key});

  @override
  ConsumerState createState() => _StatusListPageState();
}

class _StatusListPageState extends ConsumerState<TimelinePage> {
  final ScrollController _controller = ScrollController();

  void _onTapItem(Status status) {
    context.push(AppPage.statusDetail.path);
  }

  void _onTapAccount(Account account) {
    final signedInUser = ref.read(signedInUserNotifierProvider);
    // FIXME: 現状だと認証中のユーザーアカウント情報が正しく保持されていないため、サインインの処理を修正する必要がある。
    final isSignedInUser = account.id == signedInUser.id;
    context.push(isSignedInUser ? AppPage.myPage.path : AppPage.user.path);
  }

  void _onTapHashtag(String hashtag) {
    context.push(AppPage.hashTag.path);
  }

  void _onTapMention(String hashtag) {
    context.push(AppPage.user.path);
  }

  void _onTapReply(Status tappedStatus) {
    NavigatorUtil.showNewPostCreateView(
      context,
      replyToStatus: tappedStatus,
    );
  }

  Future<void> _onTapBoost(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.onTapBoost(status);
  }

  Future<void> _onTapFavorite(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.onTapFavorite(status);
  }

  void _copyLink() {
    // TODO: リンクをコピー
    NavigatorUtil.popScreen(context);
  }

  Future<void> _pinToProfile(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.pinStatusToProfile(status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  Future<void> _unpinToProfile(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.unpinStatusToProfile(status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  void _deleteAndReturnToDraft() {
    // TODO: 削除して下書きに戻す
    NavigatorUtil.popScreen(context);
  }

  Future<void> _delete(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.deleteStatus(status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  Future<void> _mute(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.muteAccount(status.account);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  void _block() {
    // TODO: ブロック
    NavigatorUtil.popScreen(context);
  }

  void _cancel() {
    NavigatorUtil.popScreen(context);
  }

  void _onTapEngagementReblog() {
    // TODO: ブーストを押したユーザー一覧を表示する画面へ遷移
  }

  void _onTapEngagementFavorite() {
    // TODO: お気に入りを押したユーザー一覧を表示する画面へ遷移
  }

  void _onTapMenu(List<StatusMenuAction> actions) {
    NavigatorUtil.showStatusMenuActionSheet(context, actions: actions);
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      await ref.read(timelineNotifierProvider.notifier).fetchTimeline();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(timelineNotifierProvider);
    final notifier = ref.read(timelineNotifierProvider.notifier);
    final signedInUser = ref.read(signedInUserNotifierProvider);
    return Scaffold(
      backgroundColor: AppColors.gray1,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8.w),
            const Icon(Icons.home),
            SizedBox(width: 8.w),
            const Text('ホーム'),
            IconButton(
              onPressed: () {
                // TODO: タイムラインの種類を切り替える。
              },
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
          ],
        ),
      ),
      body: state.isLoading && state.statuses.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: notifier.onRefresh,
              child: Scrollbar(
                controller: _controller,
                child: ListView.builder(
                  controller: _controller,
                  itemCount: state.statuses.length,
                  itemBuilder: (BuildContext context, int index) {
                    final status = state.statuses[index];
                    final isSignedInUser = status.account.id == signedInUser.id;
                    final statusMenuActions =
                        StatusMenuActionUtil.getStatusMenuActions(
                      status: status,
                      isSignedInUser: isSignedInUser,
                      onCopyLink: _copyLink,
                      onPinToProfile: () => status.isPinnedToProfile
                          ? _unpinToProfile(status)
                          : _pinToProfile(status),
                      onDeleteAndReturnToDraft: _deleteAndReturnToDraft,
                      onDelete: () => _delete(status),
                      onMute: () => _mute(status),
                      onBlock: () => _block(),
                      onCancel: _cancel,
                    );
                    return StatusItem(
                      status: status,
                      reblogAccount:
                          status.reblog == null ? null : status.account,
                      onTapItem: () => _onTapItem(status),
                      onTapAccount: () => _onTapAccount(status.account),
                      onTapHashtag: () => _onTapHashtag,
                      onTapMention: () => _onTapMention,
                      onTapReply: () => _onTapReply(status),
                      onTapBoost: () => _onTapBoost(status),
                      onTapFavorite: () => _onTapFavorite(status),
                      onTapMenu: () => _onTapMenu(statusMenuActions),
                      onCopyLink: _copyLink,
                      onPinToProfile: () =>
                          isSignedInUser ? _pinToProfile : null,
                      onUnpinToProfile: () =>
                          isSignedInUser ? _unpinToProfile : null,
                      onDeleteAndReturnToDraft: () =>
                          isSignedInUser ? _deleteAndReturnToDraft : null,
                      onDelete: () => isSignedInUser ? _delete : null,
                      onMute: () => _mute,
                      onBlock: _block,
                      onCancel: _cancel,
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigatorUtil.showNewPostCreateView(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
