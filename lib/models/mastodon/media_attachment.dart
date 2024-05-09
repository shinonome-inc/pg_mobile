import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_attachment.freezed.dart';
part 'media_attachment.g.dart';

@freezed
class MediaAttachment with _$MediaAttachment {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MediaAttachment({
    required String id,
    required String type,
    required String url,
    required String previewUrl,
    String? remoteUrl,
    required dynamic meta,
    String? description,
    required String blurhash,
  }) = _MediaAttachment;

  factory MediaAttachment.fromJson(Map<String, dynamic> json) =>
      _$MediaAttachmentFromJson(json);
}
