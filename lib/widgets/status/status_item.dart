import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/extensions/status_extension.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/util/status_menu_action_util.dart';
import 'package:pg_mobile/widgets/linkable_text.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';
import 'package:pg_mobile/widgets/status/status.dart';

class StatusItem extends StatelessWidget {
  const StatusItem({
    Key? key,
    required this.status,
    required this.signedInUser,
    this.showDetails = false,
    required this.onTapBoost,
    required this.onTapFavorite,
    required this.onPinStatus,
    required this.onDeleteAndReturnToDraft,
    required this.onDelete,
    required this.onMute,
    required this.onBlock,
  }) : super(key: key);

  final Status status;
  final Account? signedInUser;
  final bool showDetails;
  final void Function() onTapBoost;
  final void Function() onTapFavorite;
  final void Function() onPinStatus;
  final void Function() onDeleteAndReturnToDraft;
  final void Function() onDelete;
  final void Function() onMute;
  final void Function() onBlock;

  Account? get _reblogAccount => status.reblog == null ? null : status.account;

  void _onTapItem(BuildContext context) {
    context.push(AppPage.statusDetail.path);
  }

  void _onTapAccount(BuildContext context) {
    context.push(AppPage.user.path);
  }

  void _onTapReply(BuildContext context) {
    context.push(AppPage.createStatus.path);
  }

  void _onTapEngagementReblog(BuildContext context) {
    context.push(AppPage.boostUserList.path);
  }

  void _onTapEngagementFavorite(BuildContext context) {
    context.push(AppPage.favoriteUserList.path);
  }

  Future<void> _copyLink(BuildContext context) async {
    final data = ClipboardData(text: status.uriText);
    await Clipboard.setData(data);
    if (!context.mounted) return;
    context.pop();
  }

  void _onCancel(BuildContext context) {
    context.pop();
  }

  void _onTapMenu(BuildContext context) {
    final actions = StatusMenuActionUtil.getStatusMenuActions(
      status: status,
      signedInUser: signedInUser,
      onCopyLink: () => _copyLink(context),
      onPinStatus: onPinStatus,
      onDeleteAndReturnToDraft: () => onDeleteAndReturnToDraft,
      onDelete: onDelete,
      onMute: onMute,
      onBlock: onBlock,
      onCancel: () => _onCancel(context),
    );
    NavigatorUtil.showStatusMenuActionSheet(context, actions: actions);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => _onTapItem(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.gray2,
              width: showDetails ? 4.h : 0.0,
            ),
            bottom: BorderSide(
              color: AppColors.gray2,
              width: showDetails ? 4.h : 1.h,
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
                GestureDetector(
                  onTap: () => _onTapAccount(context),
                  child: NetworkImageContainer(
                    imageUrl: status.account.avatar,
                    width: 56.w,
                    height: 56.w,
                    boxShape: BoxShape.circle,
                  ),
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
                                status.account.displayName,
                                style: textTheme.bodyMedium,
                              ),
                              if (!showDetails) ...{
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    '@${status.account.username}',
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: AppColors.gray3),
                                  ),
                                ),
                                Text(
                                  status.createdAtTimeAgoText,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodyMedium!
                                      .copyWith(color: AppColors.gray3),
                                ),
                              }
                            ],
                          ),
                          if (showDetails)
                            Text(
                              '@${status.account.username}',
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!
                                  .copyWith(color: AppColors.gray3),
                            ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      LinkableText(status.contentText),
                      SizedBox(height: 8.h),
                      if (status.mediaAttachments.isNotEmpty)
                        Container(
                          height: 160.h,
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: StatusMediaView(
                            mediaAttachments: status.mediaAttachments,
                          ),
                        ),
                      if (status.showLinkPreview)
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: StatusLinkPreview(
                            url: status.urls.first,
                          ),
                        ),
                      if (showDetails)
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: StatusDetailsEngagementView(
                            status: status,
                            onTapReblog: () => _onTapEngagementReblog(context),
                            onTapFavorite: () =>
                                _onTapEngagementFavorite(context),
                          ),
                        ),
                      StatusFooter(
                        status: status,
                        showDetails: showDetails,
                        onTapReply: () => _onTapReply(context),
                        onTapBoost: onTapBoost,
                        onTapFavorite: onTapFavorite,
                        onTapMenu: () => _onTapMenu(context),
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
