import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoji.freezed.dart';
part 'emoji.g.dart';

@freezed
class Emoji with _$Emoji {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Emoji({
    required String shortcode,
    required String url,
    required String staticUrl,
    required bool visibleInPicker,
  }) = _Emoji;

  factory Emoji.fromJson(Map<String, dynamic> json) => _$EmojiFromJson(json);
}
