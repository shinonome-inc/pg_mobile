import 'package:flutter/cupertino.dart';

class DebugCupertinoAlertDialog extends StatelessWidget {
  const DebugCupertinoAlertDialog({
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
    return CupertinoAlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: <CupertinoDialogAction>[
        if (_showCancel)
          CupertinoDialogAction(
            onPressed: onPressedCancel,
            textStyle: const TextStyle(color: CupertinoColors.systemBlue),
            child: const Text('キャンセル'),
          ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: onPressedOK,
          textStyle: const TextStyle(color: CupertinoColors.systemBlue),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
