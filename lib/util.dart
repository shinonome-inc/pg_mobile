import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Util {
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
}
