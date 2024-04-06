import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_field.freezed.dart';
part 'account_field.g.dart';

@freezed
abstract class AccountField with _$AccountField {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AccountField({
    String? name,
    String? value,
    String? verifiedAt,
  }) = _AccountField;

  factory AccountField.fromJson(Map<String, dynamic> json) =>
      _$AccountFieldFromJson(json);
}
