import 'package:flutter/material.dart';
import 'package:pg_mobile/util/navigator_util.dart';

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
              NavigatorUtil.showCommonAlertDialog(
                context,
                titleText: 'titleText',
                contentText: 'contentText',
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
