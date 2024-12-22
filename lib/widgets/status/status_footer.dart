import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/widgets/status/status.dart';

class StatusFooter extends StatelessWidget {
  const StatusFooter({
    super.key,
    required this.status,
    required this.showDetails,
    required this.onTapReply,
    required this.onTapBoost,
    required this.onTapFavorite,
    required this.onTapMenu,
  });

  final Status status;
  final bool showDetails;
  final void Function() onTapReply;
  final void Function() onTapBoost;
  final void Function() onTapFavorite;
  final void Function() onTapMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatusFooterItem(
          onTap: onTapReply,
          iconData: Icons.reply,
          count: status.repliesCount,
          color: AppColors.gray3,
        ),
        const Spacer(),
        StatusFooterItem(
          onTap: onTapBoost,
          iconData: Icons.repeat,
          count: showDetails ? null : status.reblogsCount,
          color: status.reblogged ? AppColors.blue : AppColors.gray3,
        ),
        const Spacer(),
        StatusFooterItem(
          onTap: onTapFavorite,
          iconData: status.favourited ? Icons.star : Icons.star_border,
          count: showDetails ? null : status.favouritesCount,
          color: status.favourited ? AppColors.yellow : AppColors.gray3,
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTapMenu,
          child: const Icon(
            Icons.more_horiz,
            color: AppColors.gray3,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
