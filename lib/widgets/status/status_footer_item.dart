import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusFooterItem extends StatelessWidget {
  const StatusFooterItem({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.count,
    required this.color,
  });

  final void Function()? onTap;
  final IconData iconData;
  final int? count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            child: Icon(
              iconData,
              color: color,
            ),
          ),
          SizedBox(width: 4.w),
          if (count != 0 && count != null)
            Text(
              count.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: color),
            ),
        ],
      ),
    );
  }
}
