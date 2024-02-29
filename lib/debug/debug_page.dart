import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/debug/debug_cached_network_image_page.dart';
import 'package:pg_mobile/debug/debug_follower_list_page.dart';
import 'package:pg_mobile/debug/debug_text_theme_page.dart';
import 'package:pg_mobile/debug/login_sample/login_sample.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/util/navigator_util.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  Widget _button(String text, {required Function() onPressed}) {
    return Column(
      children: [
        SizedBox(height: 64.h),
        SizedBox(
          height: 40.h,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(text),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('debugページ'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _button(
            'サインイン画面',
            onPressed: () {
              NavigatorUtil.pushScreen(context, const LoginSample());
            },
          ),
          _button('タイムライン画面', onPressed: () {}),
          _button('通知画面', onPressed: () {}),
          _button(
            'TextTheme',
            onPressed: () {
              NavigatorUtil.pushScreen(context, const DebugTextThemePage());
            },
          ),
          _button(
            "フォロワー一覧画面",
            onPressed: () {
              MastodonRepository.instance.fetchFollowerList().then(
                (followerModelList) {
                  NavigatorUtil.pushScreen(
                    context,
                    DebugFollowerListPage(followerModelList: followerModelList),
                  );
                },
              );
            },
          ),
          _button(
            '画像のキャッシュ化',
            onPressed: () {
              NavigatorUtil.pushScreen(
                context,
                const DebugCachedNetworkImagePage(),
              );
            },
          ),
        ],
      ),
    );
  }
}
