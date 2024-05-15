import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class ReplyToStatusView extends StatelessWidget {
  const ReplyToStatusView({
    Key? key,
    required this.status,
  }) : super(key: key);

  final Status status;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NetworkImageContainer(
          width: 32.w,
          height: 32.w,
          imageUrl: status.account.avatar,
          borderRadius: BorderRadius.circular(32.r),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status.account.displayName,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.gray3,
                  ),
            ),
            SizedBox(height: 8.h),
            Text(
              status.contentText,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.gray3,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
