import 'package:flutter/material.dart';
import 'package:pg_mobile/pages/user/user_view.dart';
import 'package:pg_mobile/util.dart';

class OfficeDetailView extends StatelessWidget {
  const OfficeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        const Text('Office Detail'),
        TextButton(
            onPressed: () {
              Util.showBottomSheetMenu(context, const UserView());
            },
            child: const Text('User'))
      ]),
    ));
  }
}
