import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/debug_cupertino_alert_dialog.dart';
import 'package:pg_mobile/debug/debug_material_alert_dialog.dart';

class NavigatorUtil {
  static void showCommonAlertDialog(
    BuildContext context, {
    required String titleText,
    required String contentText,
    String cancelText = 'キャンセル',
    String okText = 'OK',
    void Function()? onPressedCancel,
    required void Function()? onPressedOK,
    bool hideCancel = false,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => DebugCupertinoAlertDialog(
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
          return DebugMaterialAlertDialog(
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
