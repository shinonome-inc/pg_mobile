import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_menu_action.freezed.dart';

@freezed
class StatusMenuAction with _$StatusMenuAction {
  const factory StatusMenuAction({
    required void Function() onPressed,
    required String text,
    @Default(false) bool isCancel,
  }) = _StatusMenuAction;
}
