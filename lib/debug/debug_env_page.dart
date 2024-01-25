import 'package:flutter/material.dart';
import 'package:pg_mobile/config/env.dart';

class DebugEnvPage extends StatelessWidget {
  const DebugEnvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('.env読み取り'),
      ),
      body: const Center(
        child: Text('Use Debug Mode: ${Env.useDebugMode}'),
      ),
    );
  }
}
