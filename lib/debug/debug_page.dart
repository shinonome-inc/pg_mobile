import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/debug_env_page.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({Key? key}) : super(key: key);

  final double buttonHeight = 40;

  Widget _button(String text, {required Function() onPressed}) {
    return Column(
      children: [
        const SizedBox(height: 64),
        SizedBox(
          height: buttonHeight,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "debugページ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _button("サインイン画面", onPressed: () {}),
          _button("タイムライン画面", onPressed: () {}),
          _button("通知画面", onPressed: () {}),
          _button(
            ".env",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DebugEnvPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
