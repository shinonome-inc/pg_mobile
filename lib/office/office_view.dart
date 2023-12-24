import 'package:flutter/material.dart';
import 'package:pg_mobile/office_detail/office_detail_view.dart';
import 'package:pg_mobile/util.dart';

class OfficeView extends StatelessWidget {
  const OfficeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Text('Office'),
          TextButton(
              onPressed: () {
                Util.showBottomSheetMenu(context, const OfficeDetailView());
              },
              child: const Text("Office Detail"))
        ],
      ),
    ));
  }
}
