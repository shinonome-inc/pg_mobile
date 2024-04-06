import 'package:freezed_annotation/freezed_annotation.dart';

part 'field.freezed.dart';
part 'field.g.dart';

@freezed
class Field with _$Field {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Field({
    required String name,
    required String value,
    DateTime? verifiedAt,
  }) = _Field;

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
}
