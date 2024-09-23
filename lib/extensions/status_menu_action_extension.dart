import 'package:pg_mobile/models/mastodon/status_menu_action.dart';

extension StatusMenuActionExtension on StatusMenuAction {
  bool get isCommon => type == StatusMenuActionType.common;
  bool get isOnlySignedInUser => type == StatusMenuActionType.onlySignedInUser;
  bool get isOnlyNotSignedInUser =>
      type == StatusMenuActionType.onlyNotSignedInUser;
  bool get isCancel => type == StatusMenuActionType.cancel;
  bool get isNotCancel => type != StatusMenuActionType.cancel;
}

extension StatusMenuActionsExtension on List<StatusMenuAction> {
  StatusMenuAction get cancelAction => firstWhere((action) => action.isCancel);
}
