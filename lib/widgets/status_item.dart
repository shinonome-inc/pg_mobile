import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/debug/debug_thread_page.dart';
import 'package:pg_mobile/extensions/status_extension.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/mastodon/status_menu_action.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/util/status_menu_action_util.dart';
import 'package:pg_mobile/widgets/linkable_text.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';
import 'package:pg_mobile/widgets/status_boost_label.dart';
import 'package:pg_mobile/widgets/status_engagement_view.dart';
import 'package:pg_mobile/widgets/status_footer.dart';
import 'package:pg_mobile/widgets/status_link_preview.dart';
import 'package:pg_mobile/widgets/status_media_view.dart';

class StatusItem extends ConsumerStatefulWidget {
  const StatusItem({
    super.key,
    required this.status,
    this.reblogAccount,
    this.showDetails = false,
  });

  final Status status;
  final Account? reblogAccount;
  final bool showDetails;

  @override
  ConsumerState<StatusItem> createState() => _StatusItemState();
}

class _StatusItemState extends ConsumerState<StatusItem> {
  bool get _hideDetails => !widget.showDetails;
  Account? get _reblogAccount => widget.reblogAccount;
  Status get _status => widget.status;
  bool get _showDetails => widget.showDetails;

  void _onTapHashtag(String hashtag) {
    // TODO: ハッシュタグをタップ
  }

  void _onTapMention(String hashtag) {
    // TODO: メンションをタップ
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

  Future<void> _pinToProfile() async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.pinStatusToProfile(widget.status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  Future<void> _unpinToProfile() async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.unpinStatusToProfile(widget.status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  void _deleteAndReturnToDraft() {
    // TODO: 削除して下書きに戻す
    NavigatorUtil.popScreen(context);
  }

  Future<void> _delete() async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.deleteStatus(widget.status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  Future<void> _mute() async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.muteAccount(widget.status.account);
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
  Widget build(BuildContext context) {
    final signedInUser = ref.watch(signedInUserNotifierProvider);
    final isSignedInUser = _status.account.id == signedInUser.id;
    final textTheme = Theme.of(context).textTheme;
    final statusMenuActions = StatusMenuActionUtil.getStatusMenuActions(
      status: _status,
      isSignedInUser: isSignedInUser,
      onCopyLink: _copyLink,
      onPinToProfile:
          _status.isPinnedToProfile ? _unpinToProfile : _pinToProfile,
      onDeleteAndReturnToDraft: _deleteAndReturnToDraft,
      onDelete: _delete,
      onMute: _mute,
      onBlock: _block,
      onCancel: _cancel,
    );
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushScreen(
          context,
          DebugThreadPage(selectedStatus: widget.status),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.gray2,
              width: widget.showDetails ? 4.h : 0.0,
            ),
            bottom: BorderSide(
              color: AppColors.gray2,
              width: widget.showDetails ? 4.h : 1.h,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_reblogAccount != null)
              StatusBoostLabel(name: _reblogAccount?.displayName ?? ''),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NetworkImageContainer(
                  imageUrl: _status.account.avatar,
                  width: 56.w,
                  height: 56.w,
                  boxShape: BoxShape.circle,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                _status.account.displayName,
                                style: textTheme.bodyMedium,
                              ),
                              if (_hideDetails) ...{
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    '@${_status.account.username}',
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: AppColors.gray3),
                                  ),
                                ),
                                Text(
                                  _status.createdAtTimeAgoText,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodyMedium!
                                      .copyWith(color: AppColors.gray3),
                                ),
                              }
                            ],
                          ),
                          if (_showDetails)
                            Text(
                              '@${_status.account.username}',
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!
                                  .copyWith(color: AppColors.gray3),
                            ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      LinkableText(
                        _status.contentText,
                        onTapMention: (value) => _onTapMention(value),
                        onTapHashtag: (value) => _onTapHashtag(value),
                      ),
                      SizedBox(height: 8.h),
                      if (_status.mediaAttachments.isNotEmpty)
                        Container(
                          height: 160.h,
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: StatusMediaView(
                            mediaAttachments: _status.mediaAttachments,
                          ),
                        ),
                      if (_status.showLinkPreview)
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: StatusLinkPreview(
                            url: _status.urls.first,
                          ),
                        ),
                      if (_showDetails)
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: StatusDetailsEngagementView(
                            status: _status,
                            onTapReblog: _onTapEngagementReblog,
                            onTapFavorite: _onTapEngagementFavorite,
                          ),
                        ),
                      StatusFooter(
                        status: _status,
                        showDetails: _showDetails,
                        onTapReply: () => _onTapReply(_status),
                        onTapBoost: () => _onTapBoost(_status),
                        onTapFavorite: () => _onTapFavorite(_status),
                        onTapMenu: () => _onTapMenu(statusMenuActions),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
