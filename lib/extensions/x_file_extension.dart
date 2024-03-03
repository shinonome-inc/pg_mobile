import 'package:image_picker/image_picker.dart';
import 'package:pg_mobile/models/media_type.dart';
import 'package:pg_mobile/util/media_util.dart';

extension XFileExtension on XFile {
  MediaType get mediaType => MediaUtil.judgeMediaType(this);

  bool get isImage => mediaType == MediaType.image;
  bool get isVideo => mediaType == MediaType.video;
  bool get isOther => !(isImage || isVideo);
}
