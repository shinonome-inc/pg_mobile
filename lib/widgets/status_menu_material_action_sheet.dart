import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/status_menu_action.dart';

class StatusMenuMaterialActionsSheet extends StatelessWidget {
  const StatusMenuMaterialActionsSheet({
    Key? key,
    required this.actions,
  }) : super(key: key);

  final List<StatusMenuAction> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var action in actions)
          GestureDetector(
            onTap: action.onPressed,
            child: Container(
              alignment: Alignment.center,
              height: 56.h,
              decoration: BoxDecoration(
                color: AppColors.gray1,
                border: Border(
                  top: BorderSide(
                    color: AppColors.gray2,
                    width: 2.h,
                  ),
                ),
              ),
              child: Text(
                action.text,
              ),
            ),
          )
      ],
    );
  }
}
