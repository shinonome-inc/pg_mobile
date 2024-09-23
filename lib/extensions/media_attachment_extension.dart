import 'package:pg_mobile/models/enums/attachment_media_type.dart';
import 'package:pg_mobile/models/mastodon/media_attachment.dart';

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
