import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_menu_action.freezed.dart';

enum StatusMenuActionType {
  common,
  onlySignedInUser,
  onlyNotSignedInUser,
  cancel;
}

@freezed
class StatusMenuAction with _$StatusMenuAction {
  const factory StatusMenuAction({
    required void Function() onPressed,
    required String text,
    required StatusMenuActionType type,
  }) = _StatusMenuAction;
}

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
