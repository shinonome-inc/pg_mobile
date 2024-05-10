import 'package:permission_handler/permission_handler.dart';

extension PermissionStatusExtension on PermissionStatus? {
  bool get isGranted => this?.isGranted ?? false;
}
