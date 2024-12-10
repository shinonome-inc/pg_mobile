import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/constants/border_radiuses.dart';

/// スクロール可能なModalBottomSheetのWidget。
class ScrollableModalBottomSheet extends StatelessWidget {
  const ScrollableModalBottomSheet({
    Key? key,
    this.child,
    this.physics,
  }) : super(key: key);

  final Widget? child;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _ScrollableModalBottomSheetHeader(),
            Expanded(
              child: Container(
                color: AppColors.pgritWebBackground,
                child: SingleChildScrollView(
                  physics: physics,
                  child: child,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ScrollableModalBottomSheetHeader extends StatelessWidget {
  const _ScrollableModalBottomSheetHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      alignment: Alignment.topCenter,
      height: 54.0,
      decoration: BoxDecoration(
        color: AppColors.pgritWebBackground,
        borderRadius: BorderRadiuses.modalHeaderBorderRadius,
      ),
      child: Container(
        width: 64.w,
        height: 4.0,
        decoration: BoxDecoration(
          color: AppColors.gray4,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
