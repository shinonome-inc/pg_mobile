import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/debug_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/config/env.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/constants/font_families.dart';
import 'package:pg_mobile/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.gray1,
            fontFamily: FontFamilies.notoSansJP,
            textTheme: const TextTheme(
              displayLarge: TextStyle(color: AppColors.white),
              displayMedium: TextStyle(color: AppColors.white),
              displaySmall: TextStyle(color: AppColors.white),
              headlineLarge: TextStyle(color: AppColors.white),
              headlineMedium: TextStyle(color: AppColors.white),
              headlineSmall: TextStyle(color: AppColors.white),
              titleLarge: TextStyle(color: AppColors.white),
              titleMedium: TextStyle(color: AppColors.white),
              titleSmall: TextStyle(color: AppColors.white),
              labelLarge: TextStyle(color: AppColors.white),
              labelMedium: TextStyle(color: AppColors.white),
              labelSmall: TextStyle(color: AppColors.white),
              bodyLarge: TextStyle(color: AppColors.white),
              bodyMedium: TextStyle(color: AppColors.white),
              bodySmall: TextStyle(color: AppColors.white),
            ),
            iconTheme: const IconThemeData(
              color: AppColors.white,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.gray1,
              foregroundColor: AppColors.white,
              elevation: 1.0,
              shadowColor: AppColors.gray3,
              surfaceTintColor: AppColors.transparent,
              centerTitle: true,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.accent,
                disabledBackgroundColor: AppColors.gray2,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.white,
              shape: CircleBorder(),
            ),
            dividerTheme: const DividerThemeData(
              color: AppColors.gray3,
            ),
          ),
          home: child,
        );
      },
      child: Env.useDebugMode ? const DebugPage() : const Scaffold(),
    );
  }
}
