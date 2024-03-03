import 'package:image_picker/image_picker.dart';
import 'package:pg_mobile/models/media_type.dart';
import 'package:pg_mobile/util/media_util.dart';

extension XFileExtension on XFile {
  MediaType get mediaType => MediaUtil.judgeMediaType(this);

  /// ファイルの種類が画像かどうか判定します。
  bool get isImage => mediaType == MediaType.image;

  /// ファイルの種類が動画かどうか判定します。
  bool get isVideo => mediaType == MediaType.video;

  /// ファイルの種類が画像と動画以外かどうか判定します。
  bool get isOther => !(isImage || isVideo);
}
