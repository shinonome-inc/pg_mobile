import 'package:flutter/material.dart';
import 'package:pg_mobile/pages/post_detail/post_detail_view.dart';
import 'package:pg_mobile/pages/user/user_view.dart';
import 'package:pg_mobile/util/navigator_util.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Text('Notifications'),
          TextButton(
              onPressed: () {
                NavigatorUtil.showBottomSheetMenu(context, const UserView());
              },
              child: const Text('User')),
          TextButton(
              onPressed: () {
                NavigatorUtil.showBottomSheetMenu(
                    context, const PostDetailView());
              },
              child: const Text('Detail'))
        ],
      ),
    ));
  }
}
