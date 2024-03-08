import 'package:flutter/material.dart';
import 'package:pg_mobile/util/platform_modal_handler.dart';

class DebugAlertDialogPage extends StatelessWidget {
  const DebugAlertDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Dialog'),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              PlatformModalHandler.showCommonAlertDialog(
                context,
                titleText: 'titleText',
                contentText: 'contentText',
                onPressedCancel: () {
                  Navigator.pop(context);
                },
                onPressedOK: () {
                  Navigator.pop(context);
                },
              );
            },
            child: const Text('AlertDialogを表示'),
          ),
        ),
      ),
    );
  }
}
