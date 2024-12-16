import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/config/app_theme.dart';
import 'package:pg_mobile/config/env.dart';
import 'package:pg_mobile/config/router.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/repository/settings_repository.dart';

import 'constants/sizes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('Env.useDebugMode: ${Env.useDebugMode}');
  MastodonRepository.instance.init();
  SettingsRepository.instance.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Sizes.designSize,
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp.router(
          title: 'PG Mobile',
          theme: appTheme(),
          routerConfig: router,
        );
      },
    );
  }
}
