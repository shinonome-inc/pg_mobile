import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/attachment_media_type.dart';

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

extension MediaAttachmentsExtension on List<MediaAttachment> {
  MediaAttachmentType get _type {
    switch (first.type) {
      case 'image':
        return MediaAttachmentType.image;
      case 'gifv':
        return MediaAttachmentType.gifv;
      case 'video':
        return MediaAttachmentType.video;
      case 'audio':
        return MediaAttachmentType.audio;
      default:
        return MediaAttachmentType.unknown;
    }
  }

  bool get isImage => _type == MediaAttachmentType.image;
  bool get isGifv => _type == MediaAttachmentType.gifv;
  bool get isVideo => _type == MediaAttachmentType.video;
  bool get isAudio => _type == MediaAttachmentType.audio;
  bool get isUnknown => _type == MediaAttachmentType.unknown;
}
