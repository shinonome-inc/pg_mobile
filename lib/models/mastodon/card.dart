import 'package:freezed_annotation/freezed_annotation.dart';

part 'card.freezed.dart';
part 'card.g.dart';

@freezed
abstract class Card with _$Card {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Card({
    String? url,
    String? title,
    String? description,
    String? type,
    String? authorName,
    String? authorUrl,
    String? providerName,
    String? providerUrl,
    String? html,
    int? width,
    int? height,
    dynamic image,
    String? embedUrl,
  }) = _Card;

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
}
