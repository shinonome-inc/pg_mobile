import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateStatusPage extends ConsumerStatefulWidget {
  const CreateStatusPage({super.key});

  @override
  ConsumerState createState() => _CreateStatusPageState();
}

class _CreateStatusPageState extends ConsumerState<CreateStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Status Page'),
      ),
    );
  }
}
