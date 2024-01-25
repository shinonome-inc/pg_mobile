import 'package:flutter/material.dart';
import 'package:pg_mobile/config/env.dart';
import 'package:pg_mobile/debug/debug_page.dart';

void main() {
  debugPrint('Env.useDebugMode: ${Env.useDebugMode}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // TODO: Scaffoldを正規の画面に置き換える。
      home: Env.useDebugMode ? const DebugPage() : const Scaffold(),
    );
  }
}
