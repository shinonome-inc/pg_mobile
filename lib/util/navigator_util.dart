import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/mastodon/status_menu_action.dart';
import 'package:pg_mobile/widgets/network_gifv_preview.dart';
import 'package:pg_mobile/widgets/network_image_preview.dart';
import 'package:pg_mobile/widgets/network_video_preview.dart';
import 'package:pg_mobile/widgets/new_post_modal_bottom_sheet.dart';
import 'package:pg_mobile/widgets/status_menu_cupertino_action_sheet.dart';
import 'package:pg_mobile/widgets/status_menu_material_action_sheet.dart';
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

  static void showNewPostCreateView(
    BuildContext context, {
    Status? replyToStatus,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return NewPostModalBottomSheet(replyToStatus: replyToStatus);
      },
    );
  }

  static void showStatusMenuActionSheet(
    BuildContext context, {
    required List<StatusMenuAction> actions,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => StatusMenuCupertinoActionSheet(
          actions: actions,
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => StatusMenuMaterialActionsSheet(
          actions: actions,
        ),
      );
    }
  }
}
