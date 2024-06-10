import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/widgets/buttons/pg_mobile_default_button.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class FavoriteUserItem extends StatelessWidget {
  const FavoriteUserItem({required this.account, super.key});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          NetworkImageContainer(
            imageUrl: account.avatar,
            height: 64.h,
            width: 64.w,
            boxShape: BoxShape.circle,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.displayName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 5.h),
                Text(
                  '@${account.username}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.gray3),
                ),
              ],
            ),
          ),
          PgMobileDefaultButton(
            backgroundColor: AppColors.accent,
            onPressed: () {},
            buttonText: 'フォロー',
            buttonTextStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w700),
            buttonHeight: 32.h,
            buttonWidth: 104.w,
          ),
        ],
      ),
    );
  }
}
