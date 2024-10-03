import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';

class StatusBoostLabel extends StatelessWidget {
  const StatusBoostLabel({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          SizedBox(width: 40.w),
          const Icon(
            Icons.repeat,
            color: AppColors.gray3,
          ),
          SizedBox(width: 8.w),
          Text(
            '${name}さんがブースト',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.gray3),
          ),
        ],
      ),
    );
  }
}
