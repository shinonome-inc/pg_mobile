import 'package:flutter/cupertino.dart';
import 'package:pg_mobile/models/mastodon/status_menu_action.dart';

class StatusMenuActionSheet extends StatelessWidget {
  const StatusMenuActionSheet({
    Key? key,
    required this.actions,
  }) : super(key: key);

  final List<StatusMenuAction> actions;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: CupertinoColors.systemBlue);
    final cancelAction = actions.firstWhere((action) => action.isCancel);
    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        for (var actions in actions)
          if (!actions.isCancel)
            CupertinoActionSheetAction(
              onPressed: actions.onPressed,
              child: Text(
                actions.text,
                style: style,
              ),
            ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: cancelAction.onPressed,
        child: Text(cancelAction.text),
      ),
    );
  }
}
