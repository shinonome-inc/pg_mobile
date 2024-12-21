import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/extensions/build_context_extension.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/widgets/linkable_text.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({
    super.key,
    required this.user,
    required this.onTapStatusCount,
    required this.onTapFollowingCount,
    required this.onTapFollowerCount,
  });

  final Account user;
  final void Function() onTapStatusCount;
  final void Function() onTapFollowingCount;
  final void Function() onTapFollowerCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            NetworkImageContainer(
              imageUrl: user.header,
              aspectRatio: 375 / 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 56.h),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName,
                        style: context.textTheme.titleLargeBold,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '@${user.username}',
                        style: context.textTheme.bodyMediumNormal?.copyWith(
                          color: AppColors.gray4,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      LinkableText(
                        user.note,
                        onTapMention: (value) {},
                        onTapHashtag: (value) {},
                      ),
                      SizedBox(width: 16.h),
                      Row(
                        children: [
                          _UserActivityCountItem(
                            onTap: onTapStatusCount,
                            count: user.statusesCount,
                            label: '投稿',
                          ),
                          SizedBox(width: 16.w),
                          _UserActivityCountItem(
                            onTap: onTapFollowingCount,
                            count: user.followingCount,
                            label: 'フォロー',
                          ),
                          SizedBox(width: 16.w),
                          _UserActivityCountItem(
                            onTap: onTapFollowerCount,
                            count: user.followersCount,
                            label: 'フォロワー',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 160.h,
          left: 16.0,
          child: NetworkImageContainer(
            imageUrl: user.avatar,
            padding: EdgeInsets.all(4.h),
            backgroundColor: AppColors.gray2,
            width: 88.h,
            height: 88.h,
            boxShape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class _UserActivityCountItem extends StatelessWidget {
  const _UserActivityCountItem({
    required this.onTap,
    required this.count,
    required this.label,
  });

  final void Function() onTap;
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            count.toString(),
            style: context.textTheme.bodyMediumBold,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: context.textTheme.bodySmallNormal?.copyWith(
              color: AppColors.gray4,
            ),
          ),
        ],
      ),
    );
  }
}
