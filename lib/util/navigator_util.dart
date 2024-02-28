import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/extensions/target_platform_extension.dart';
import 'package:pg_mobile/widgets/common_cupertino_alert_dialog.dart';
import 'package:pg_mobile/widgets/common_material_alert_dialog.dart';

class NavigatorUtil {
  /// OSに応じたAlertDialogを表示するメソッド
  static void showCommonAlertDialog(
    BuildContext context, {
    required String titleText,
    required String contentText,
    String cancelText = 'キャンセル',
    String okText = 'OK',
    required void Function()? onPressedCancel,
    required void Function()? onPressedOK,
    bool hideCancel = false,
  }) {
    if (Theme.of(context).platform.isIOS) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CommonCupertinoAlertDialog(
          titleText: titleText,
          contentText: contentText,
          cancelText: cancelText,
          okText: okText,
          onPressedCancel: onPressedCancel,
          onPressedOK: onPressedOK,
          hideCancel: hideCancel,
        ),
      );
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CommonMaterialAlertDialog(
            titleText: titleText,
            contentText: contentText,
            cancelText: cancelText,
            okText: okText,
            onPressedCancel: onPressedCancel,
            onPressedOK: onPressedOK,
            hideCancel: hideCancel,
          );
        },
      );
    }
  }
}
