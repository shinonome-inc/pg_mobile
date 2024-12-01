import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/extensions/status_extension.dart';
import 'package:pg_mobile/models/mastodon/status.dart';

class StatusDetailsEngagementView extends StatelessWidget {
  const StatusDetailsEngagementView({
    Key? key,
    required this.status,
    required this.onTapReblog,
    required this.onTapFavorite,
  }) : super(key: key);

  final Status status;
  final Function()? onTapReblog;
  final Function()? onTapFavorite;

  @override
  Widget build(BuildContext context) {
    final TextStyle normalStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: AppColors.gray3);
    final TextStyle emphasisStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: AppColors.white, fontWeight: FontWeight.bold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          status.createdAtText,
          style: normalStyle,
        ),
        Row(
          children: [
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = onTapReblog,
                children: [
                  TextSpan(
                    text: status.reblogsCount.toString(),
                    style: emphasisStyle,
                  ),
                  TextSpan(
                    text: '件のブースト',
                    style: normalStyle,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = onTapFavorite,
                children: [
                  TextSpan(
                    text: status.favouritesCount.toString(),
                    style: emphasisStyle,
                  ),
                  TextSpan(
                    text: '件のお気に入り',
                    style: normalStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
