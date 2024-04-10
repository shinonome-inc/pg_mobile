import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_emoji.freezed.dart';
part 'custom_emoji.g.dart';

@freezed
class CustomEmoji with _$CustomEmoji {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CustomEmoji({
    required String shortcode,
    required String url,
    required String staticUrl,
    required bool visibleInPicker,
  }) = _CustomEmoji;

  factory CustomEmoji.fromJson(Map<String, dynamic> json) =>
      _$CustomEmojiFromJson(json);
}
