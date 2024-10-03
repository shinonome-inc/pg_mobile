import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/debug/debug_thread_page.dart';
import 'package:pg_mobile/extensions/status_extension.dart';
import 'package:pg_mobile/extensions/status_menu_action_extension.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/mastodon/status_menu_action.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/util/navigator_util.dart';
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

  void _copyLink() {
    // TODO: リンクをコピー
    NavigatorUtil.popScreen(context);
  }

  void _pinToProfile() {
    // TODO: プロフィールに固定
    NavigatorUtil.popScreen(context);
  }

  void _deleteAndReturnToDraft() {
    // TODO: 削除して下書きに戻す
    NavigatorUtil.popScreen(context);
  }

  void _delete() {
    // TODO: 削除
    NavigatorUtil.popScreen(context);
  }

  void _mute() {
    // TODO: ミュート
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
    final signedInUser = ref.watch(signedInUserNotifierProvider);
    final isSignedInUser = widget.status.account.id == signedInUser.id;
    actions.removeWhere((action) {
      final isUnnecessary = isSignedInUser
          ? action.isOnlyNotSignedInUser
          : action.isOnlySignedInUser;
      return isUnnecessary;
    });
    NavigatorUtil.showStatusMenuActionSheet(context, actions: actions);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    final statusMenuActions = [
      StatusMenuAction(
        onPressed: _copyLink,
        text: 'リンクをコピー',
        type: StatusMenuActionType.common,
      ),
      StatusMenuAction(
        onPressed: _pinToProfile,
        text: 'プロフィールに固定',
        type: StatusMenuActionType.onlySignedInUser,
      ),
      StatusMenuAction(
        onPressed: _deleteAndReturnToDraft,
        text: '削除して下書きに戻す',
        type: StatusMenuActionType.onlySignedInUser,
        isDestructiveAction: true,
      ),
      StatusMenuAction(
        onPressed: _delete,
        text: '削除',
        type: StatusMenuActionType.onlySignedInUser,
        isDestructiveAction: true,
      ),
      StatusMenuAction(
        onPressed: _mute,
        text: '${widget.status.account.username}さんをミュート',
        type: StatusMenuActionType.onlyNotSignedInUser,
      ),
      StatusMenuAction(
        onPressed: _block,
        text: '${widget.status.account.username}さんをブロック',
        type: StatusMenuActionType.onlyNotSignedInUser,
        isDestructiveAction: true,
      ),
      StatusMenuAction(
        onPressed: _cancel,
        text: 'キャンセル',
        type: StatusMenuActionType.cancel,
        isDestructiveAction: true,
      ),
    ];
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
            if (widget.reblogAccount != null)
              StatusBoostLabel(name: widget.reblogAccount?.displayName ?? ''),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NetworkImageContainer(
                  imageUrl: widget.status.account.avatar,
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
                                widget.status.account.displayName,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              if (_hideDetails) ...{
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    '@${widget.status.account.username}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.gray3),
                                  ),
                                ),
                                Text(
                                  widget.status.createdAtTimeAgoText,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.gray3),
                                ),
                              }
                            ],
                          ),
                          if (widget.showDetails)
                            Text(
                              '@${widget.status.account.username}',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.gray3),
                            ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      LinkableText(
                        widget.status.contentText,
                        onTapMention: (value) => _onTapMention(value),
                        onTapHashtag: (value) => _onTapHashtag(value),
                      ),
                      SizedBox(height: 8.h),
                      if (widget.status.mediaAttachments.isNotEmpty) ...{
                        SizedBox(
                          height: 160.h,
                          child: StatusMediaView(
                            mediaAttachments: widget.status.mediaAttachments,
                          ),
                        ),
                        SizedBox(height: 8.h),
                      },
                      if (widget.status.showLinkPreview) ...{
                        StatusLinkPreview(
                          url: widget.status.urls.first,
                        ),
                        SizedBox(height: 8.h),
                      },
                      if (widget.showDetails) ...{
                        StatusDetailsEngagementView(
                          status: widget.status,
                          onTapReblog: _onTapEngagementReblog,
                          onTapFavorite: _onTapEngagementFavorite,
                        ),
                        SizedBox(height: 8.h),
                      },
                      StatusFooter(
                        status: widget.status,
                        showDetails: widget.showDetails,
                        onTapReply: () => _onTapReply(widget.status),
                        onTapBoost: () => notifier.onTapBoost(widget.status),
                        onTapFavorite: () =>
                            notifier.onTapFavorite(widget.status),
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
