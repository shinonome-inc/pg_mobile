import 'package:image_picker/image_picker.dart';
import 'package:pg_mobile/models/media_type.dart';

class MediaUtil {
  MediaUtil._();

  static MediaType judgeMediaType(XFile file) {
    // ファイルのパスを取得
    final path = file.path;
    // ファイルの拡張子を取得
    final fileExtension = path.split('.').last.toLowerCase();
    // 一般的な画像ファイルの拡張子
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    // 一般的な動画ファイルの拡張子
    final videoExtensions = ['mp4', 'mov', 'avi', 'mkv', 'wmv'];
    // 拡張子を元にファイルの種類を判定
    if (imageExtensions.contains(fileExtension)) {
      return MediaType.image;
    } else if (videoExtensions.contains(fileExtension)) {
      return MediaType.video;
    } else {
      return MediaType.other;
    }
  }
}
