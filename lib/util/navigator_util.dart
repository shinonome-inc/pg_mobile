import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pg_mobile/widgets/image_preview.dart';

class NavigatorUtil {
  NavigatorUtil._();

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

  static void showImagePreview(BuildContext context, String imageUrl) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return ImagePreview(imageUrl: imageUrl);
      },
    );
  }
}
