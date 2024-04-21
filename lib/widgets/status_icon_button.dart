import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';

class StatusIconButton extends StatelessWidget {
  final String imagePath;
  final int count;
  const StatusIconButton(
      {super.key, required this.imagePath, required this.count});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Image.asset(
              imagePath,
            ),
          ),
          const SizedBox(width: 4),
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
