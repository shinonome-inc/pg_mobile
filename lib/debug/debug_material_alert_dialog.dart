import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';

class DebugMaterialAlertDialog extends StatelessWidget {
  const DebugMaterialAlertDialog({
    Key? key,
    required this.titleText,
    required this.contentText,
    required this.cancelText,
    required this.okText,
    required this.onPressedCancel,
    required this.onPressedOK,
    required this.hideCancel,
  }) : super(key: key);

  final String titleText;
  final String contentText;
  final String cancelText;
  final String okText;
  final void Function()? onPressedCancel;
  final void Function()? onPressedOK;
  final bool hideCancel;

  bool get _showCancel => !hideCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titleText,
        style: const TextStyle(color: AppColors.black),
      ),
      content: Text(
        contentText,
        style: const TextStyle(color: AppColors.black),
      ),
      actions: <Widget>[
        if (_showCancel)
          TextButton(
            onPressed: onPressedCancel,
            child: Text(cancelText),
          ),
        TextButton(
          onPressed: onPressedOK,
          child: Text(okText),
        ),
      ],
    );
  }
}
