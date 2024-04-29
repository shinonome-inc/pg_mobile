import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';

class StatusIconButton extends StatelessWidget {
  final IconData iconData;
  final int count;
  const StatusIconButton(
      {super.key, required this.iconData, required this.count});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SizedBox(
            height: 24.h,
            width: 24.w,
            child: Icon(iconData, color: AppColors.gray3),
          ),
          SizedBox(width: 4.w),
          if (count > 0) ...[
            Text(
              count.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.gray3),
            ),
          ],
        ],
      ),
    );
  }
}
