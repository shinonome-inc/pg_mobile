import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pg_mobile/extensions/target_platform_extension.dart';
import 'package:pg_mobile/widgets/common_cupertino_alert_dialog.dart';
import 'package:pg_mobile/widgets/common_material_alert_dialog.dart';
import 'package:pg_mobile/widgets/metwork_image_preview.dart';

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

  static void showBottomSheetMenu(BuildContext context, Widget child) {
    showCupertinoModalBottomSheet(
        context: context,
        builder: (builder) {
          return child;
        });
  }

  static void pushScreen(BuildContext context, Widget child) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => child),
    );
  }

  static void popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void showNetworkImagePreview(BuildContext context, String imageUrl) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return NetworkImagePreview(imageUrl: imageUrl);
      },
    );
  }
}
