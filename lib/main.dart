import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/config/env.dart';
import 'package:pg_mobile/constants/font_families.dart';
import 'package:pg_mobile/constants/styles.dart';
import 'package:pg_mobile/debug/debug_page.dart';

void main() {
  debugPrint('Env.useDebugMode: ${Env.useDebugMode}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'PG Mobile',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Styles.accent),
            useMaterial3: true,
            scaffoldBackgroundColor: Styles.gray1,
            fontFamily: FontFamilies.notoSansJP,
            appBarTheme: const AppBarTheme(
              backgroundColor: Styles.gray1,
              foregroundColor: Styles.white,
              elevation: 1.0,
              shadowColor: Styles.gray3,
              surfaceTintColor: Styles.transparent,
              centerTitle: true,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Styles.white,
                backgroundColor: Styles.accent,
                disabledBackgroundColor: Styles.gray2,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Styles.accent,
              foregroundColor: Styles.white,
              shape: CircleBorder(),
            ),
          ),
          home: child,
        );
      },
      child: Env.useDebugMode ? const DebugPage() : const Scaffold(),
    );
  }
}
