import 'package:freezed_annotation/freezed_annotation.dart';

part 'preview_card.freezed.dart';
part 'preview_card.g.dart';

@freezed
class PreviewCard with _$PreviewCard {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PreviewCard({
    required String url,
    required String title,
    required String description,
    required String type,
    required String authorName,
    required String authorUrl,
    required String providerName,
    required String providerUrl,
    required String html,
    required int width,
    required int height,
    String? image,
    required String embedUrl,
    String? blurhash,
  }) = _PreviewCard;
  factory PreviewCard.fromJson(Map<String, dynamic> json) =>
      _$PreviewCardFromJson(json);
}
