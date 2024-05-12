import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pg_mobile/widgets/network_gifv_preview.dart';
import 'package:pg_mobile/widgets/network_image_preview.dart';
import 'package:pg_mobile/widgets/network_video_preview.dart';
import 'package:video_player/video_player.dart';

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

  static void popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void showNetworkImagePreview({
    required BuildContext context,
    required List<String> imageUrls,
    required int selectedIndex,
  }) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return NetworkImagePreview(
          imageUrls: imageUrls,
          selectedIndex: selectedIndex,
        );
      },
    );
  }

  static void showNetworkVideoPreview({
    required BuildContext context,
    required VideoPlayerController controller,
  }) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return NetworkVideoPreview(
          controller: controller,
        );
      },
    );
  }

  static void showNetworkGifvPreview({
    required BuildContext context,
    required VideoPlayerController controller,
  }) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return NetworkGifvPreview(
          controller: controller,
        );
      },
    );
  }
}
