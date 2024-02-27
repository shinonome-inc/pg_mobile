import 'package:flutter/cupertino.dart';

class DebugCupertinoAlertDialog extends StatelessWidget {
  const DebugCupertinoAlertDialog({
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

  static const TextStyle _actionsTextStyle = TextStyle(
    color: CupertinoColors.systemBlue,
  );

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
            textStyle: _actionsTextStyle,
            child: Text(cancelText),
          ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: onPressedOK,
          textStyle: _actionsTextStyle,
          child: Text(okText),
        ),
      ],
    );
  }
}
