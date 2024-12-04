import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/config/app_theme.dart';
import 'package:pg_mobile/constants/sizes.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'widgetbook.directories.g.dart';

void main() {
  runApp(const MyApp());
}

/// アプリ全体の初期化を行うウィジェット。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Sizes.designSize,
      minTextAdapt: true,
      builder: (_, child) {
        return const MaterialApp(
          title: 'PG Mobile Widgetbook',
          debugShowCheckedModeBanner: false,
          home: WidgetbookApp(),
        );
      },
    );
  }
}

/// Widgetbookのエントリーポイント。
@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: <WidgetbookAddon>[
        MaterialThemeAddon(
          themes: <WidgetbookTheme<ThemeData>>[
            WidgetbookTheme<ThemeData>(
              name: 'App Theme',
              data: appTheme(),
            ),
          ],
        ),
        InspectorAddon(
          enabled: true,
        ),
        DeviceFrameAddon(
          devices: <DeviceInfo>[
            Devices.ios.iPhone13,
            Devices.ios.iPhoneSE,
            Devices.android.mediumPhone,
          ],
        ),
      ],
    );
  }
}

/// Widgetbookで表示するWidgetのラッパークラス。
///
/// DeviceFrameAddonを使用する場合、カラーが適用されなかったり、フレームにUIパーツが重なったりするのを防ぐために使用する。
class WidgetbookWrapper extends StatelessWidget {
  const WidgetbookWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(child: child),
    );
  }
}
