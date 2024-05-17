import 'package:flutter/cupertino.dart';
import 'package:pg_mobile/models/mastodon/status_menu_action.dart';

class StatusMenuActionSheet extends StatelessWidget {
  const StatusMenuActionSheet({
    Key? key,
    required this.statusMenuActions,
    required this.isSignedInUser,
  }) : super(key: key);

  final List<StatusMenuAction> statusMenuActions;
  final bool isSignedInUser;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: CupertinoColors.systemBlue);
    print('isSignedInUser: $isSignedInUser');
    for (var item in statusMenuActions) {
      print(item.type);
    }
    final actions = statusMenuActions.where(
      (action) =>
          action.isCommon ||
          (isSignedInUser
              ? action.isOnlySignedInUser
              : action.isOnlyNotSignedInUser),
    );
    final cancelAction = statusMenuActions.firstWhere(
      (action) => action.isCancel,
    );
    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        for (var action in actions)
          if (action.isNotCancel)
            CupertinoActionSheetAction(
              onPressed: action.onPressed,
              child: Text(
                action.text,
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
