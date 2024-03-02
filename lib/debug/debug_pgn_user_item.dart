import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/debug/debug_pix_text.dart';
import 'package:pg_mobile/models/pgn_user.dart';

class DebugPGNUserItem extends StatelessWidget {
  const DebugPGNUserItem({
    Key? key,
    required this.ranking,
    required this.user,
  }) : super(key: key);

  final int ranking;
  final PGNUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray2,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 8.w,
            ),
            width: 88.w,
            decoration: BoxDecoration(
              color: AppColors.gray2,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Image(
                  width: 32.w,
                  height: 32.w,
                  image: AssetImage(user.rankImagePath),
                ),
                Text(
                  user.rankText,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text('#$ranking'),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${user.id}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 8.h),
              DebugPIXText(
                title: 'Total ',
                pix: user.total,
              ),
              DebugPIXText(
                title: 'Dawn',
                pix: user.totalDawn,
              ),
              DebugPIXText(
                title: 'PGrit ',
                pix: user.totalPgrit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
