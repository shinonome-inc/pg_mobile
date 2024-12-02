import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';

/// SettingsSectionItemTypeの種類を表す列挙型。
enum SettingsSectionItemType {
  normal,
  top,
  bottom,
  single;

  bool get _isTop => this == SettingsSectionItemType.top;
  bool get _isBottom => this == SettingsSectionItemType.bottom;
  bool get _isSingle => this == SettingsSectionItemType.single;

  bool get _isTopRounded => _isTop || _isSingle;
  bool get _isBottomRounded => _isBottom || _isSingle;
}

/// 設定画面のセクションのアイテムのWidget。
///
/// [type]の値に応じて、背景の角丸を変更する。
///
class SettingsSectionItem extends StatelessWidget {
  const SettingsSectionItem({
    super.key,
    this.onTap,
    required this.title,
    required this.action,
    this.type = SettingsSectionItemType.normal,
  });

  final void Function()? onTap;
  final Widget title;
  final Widget action;
  final SettingsSectionItemType type;

  BorderRadius get _borderRadius {
    return BorderRadius.vertical(
      top: type._isTopRounded ? Radius.circular(8.r) : Radius.zero,
      bottom: type._isBottomRounded ? Radius.circular(8.r) : Radius.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: _borderRadius,
          child: Ink(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.gray2,
              borderRadius: _borderRadius,
            ),
            child: Row(
              children: [
                title,
                const Spacer(),
                action,
              ],
            ),
          ),
        ),
        if (!type._isBottomRounded) SizedBox(height: 2.h),
      ],
    );
  }
}
