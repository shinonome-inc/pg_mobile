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
    @Default(false) bool isDestructiveAction,
  }) = _StatusMenuAction;
}
