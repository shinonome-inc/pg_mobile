enum MediaAttachmentType {
  unknown,
  image,
  gifv,
  video,
  audio;

  String get text {
    switch (this) {
      case MediaAttachmentType.unknown:
        return 'unknown';
      case MediaAttachmentType.image:
        return 'image';
      case MediaAttachmentType.gifv:
        return 'gifv';
      case MediaAttachmentType.video:
        return 'video';
      case MediaAttachmentType.audio:
        return 'audio';
    }
  }
}
