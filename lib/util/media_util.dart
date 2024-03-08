import 'package:image_picker/image_picker.dart';
import 'package:pg_mobile/models/media_type.dart';

/// 画像や動画などのメディアに関するユーティリティークラスです。
class MediaUtil {
  MediaUtil._();

  /// アルバムから複数の画像や動画を取得します。
  static Future<List<XFile?>> pickMultipleMediaFromGallery() async {
    final picker = ImagePicker();
    List<XFile?> files;
    try {
      files = await picker.pickMultipleMedia();
    } catch (e) {
      throw Exception('Failed to pick multiple media from gallery: $e');
    }
    return files;
  }

  /// カメラを起動して撮影した画像を取得します。
  static Future<XFile?> pickImageFromCamera() async {
    final picker = ImagePicker();
    XFile? file;
    try {
      file = await picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      throw Exception('Failed to pick image from camera: $e');
    }
    return file;
  }

  /// ファイルの拡張子からメディアタイプを判定します。
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
