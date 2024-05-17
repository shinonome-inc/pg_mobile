import 'package:flutter/cupertino.dart';
import 'package:pg_mobile/models/mastodon/status_menu_action.dart';

class StatusMenuCupertinoActionSheet extends StatelessWidget {
  const StatusMenuCupertinoActionSheet({
    Key? key,
    required this.actions,
  }) : super(key: key);

  final List<StatusMenuAction> actions;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: CupertinoColors.systemBlue);
    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        for (var action in actions)
          if (action.isNotCancel)
            CupertinoActionSheetAction(
              onPressed: action.onPressed,
              isDestructiveAction: action.isDestructiveAction,
              child: Text(
                action.text,
                style: style,
              ),
            ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: actions.cancelAction.onPressed,
        child: Text(actions.cancelAction.text),
      ),
    );
  }
}
