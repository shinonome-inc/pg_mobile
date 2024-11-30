import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/debug/debug_thread_page.dart';
import 'package:pg_mobile/extensions/status_extension.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/widgets/linkable_text.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';
import 'package:pg_mobile/widgets/status_boost_label.dart';
import 'package:pg_mobile/widgets/status_engagement_view.dart';
import 'package:pg_mobile/widgets/status_footer.dart';
import 'package:pg_mobile/widgets/status_link_preview.dart';
import 'package:pg_mobile/widgets/status_media_view.dart';

class StatusItem extends StatelessWidget {
  const StatusItem({
    Key? key,
    required this.status,
    this.reblogAccount,
    this.showDetails = false,
    required this.onTapHashtag,
    required this.onTapMention,
    required this.onTapReply,
    required this.onTapBoost,
    required this.onTapFavorite,
    required this.onTapMenu,
    required this.onCopyLink,
    required this.onPinToProfile,
    required this.onUnpinToProfile,
    required this.onDeleteAndReturnToDraft,
    required this.onDelete,
    required this.onMute,
    required this.onBlock,
    required this.onCancel,
    this.onTapEngagementReblog,
    this.onTapEngagementFavorite,
  }) : super(key: key);

  final Status status;
  final Account? reblogAccount;
  final bool showDetails;

  final void Function() onTapHashtag;
  final void Function() onTapMention;
  final void Function() onTapReply;
  final void Function() onTapBoost;
  final void Function() onTapFavorite;
  final void Function() onTapMenu;
  final void Function() onCopyLink;
  final void Function() onPinToProfile;
  final void Function() onUnpinToProfile;
  final void Function() onDeleteAndReturnToDraft;
  final void Function() onDelete;
  final void Function() onMute;
  final void Function() onBlock;
  final void Function() onCancel;
  final void Function()? onTapEngagementReblog;
  final void Function()? onTapEngagementFavorite;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushScreen(
          context,
          DebugThreadPage(selectedStatus: status),
        );
      },
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
            if (reblogAccount != null)
              StatusBoostLabel(name: reblogAccount?.displayName ?? ''),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NetworkImageContainer(
                  imageUrl: status.account.avatar,
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
                      LinkableText(
                        status.contentText,
                        onTapMention: (value) => onTapMention,
                        onTapHashtag: (value) => onTapHashtag,
                      ),
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
                            onTapReblog: onTapEngagementReblog,
                            onTapFavorite: onTapEngagementFavorite,
                          ),
                        ),
                      StatusFooter(
                        status: status,
                        showDetails: showDetails,
                        onTapReply: onTapReply,
                        onTapBoost: onTapBoost,
                        onTapFavorite: onTapFavorite,
                        onTapMenu: onTapMenu,
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
