import 'package:flutter/material.dart';
import 'package:pg_mobile/pages/office_detail/office_detail_view.dart';
import 'package:pg_mobile/util/navigator_util.dart';

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
                NavigatorUtil.showBottomSheetMenu(
                    context, const OfficeDetailView());
              },
              child: const Text("Office Detail"))
        ],
      ),
    ));
  }
}
