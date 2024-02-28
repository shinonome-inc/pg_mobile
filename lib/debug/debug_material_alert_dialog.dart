import 'package:flutter/material.dart';

class DebugMaterialAlertDialog extends StatelessWidget {
  const DebugMaterialAlertDialog({
    Key? key,
    required this.titleText,
    required this.contentText,
    required this.onPressedCancel,
    required this.onPressedOK,
    required this.hideCancel,
  }) : super(key: key);

  final String titleText;
  final String contentText;
  final void Function()? onPressedCancel;
  final void Function()? onPressedOK;
  final bool hideCancel;

  bool get _showCancel => !hideCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: <Widget>[
        if (_showCancel)
          TextButton(
            onPressed: onPressedCancel,
            child: const Text('キャンセル'),
          ),
        TextButton(
          onPressed: onPressedOK,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
