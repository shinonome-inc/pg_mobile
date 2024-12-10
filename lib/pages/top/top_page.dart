import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/constants/border_radiuses.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:pg_mobile/pages/top/top_view.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/widgets/scrollable_modal_bottom_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TopPage extends ConsumerStatefulWidget {
  const TopPage({super.key});

  @override
  ConsumerState createState() => _TopPageState();
}

class _TopPageState extends ConsumerState<TopPage> {
  late WebViewController _controller;
  double height = 640;

  void _onTapSignIn() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiuses.modalHeaderBorderRadius,
      ),
      backgroundColor: AppColors.transparent,
      builder: (context) {
        return ScrollableModalBottomSheet(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: height,
            child: WebViewWidget(controller: _controller),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (String url) async {
              print('onPageFinished: $url');
              const String javaScript =
                  'document.documentElement.scrollHeight;';
              final result =
                  await _controller.runJavaScriptReturningResult(javaScript);
              setState(() {
                height = double.parse(result.toString());
              });
              print('height: $height');
              final uri = Uri.parse(url);
              if (uri.queryParameters['code'] == null) return;
              final accessToken =
                  await MastodonRepository.instance.obtainToken(uri);
              print('accessToken: $accessToken');
              if (accessToken == null) return;
              if (!mounted) return;
              context.pushReplacement(AppPage.timeline.path);
            },
          ),
        )
        ..loadRequest(Uri.parse(MastodonRepository.authorizeUrl));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopView(
        onTapSignIn: _onTapSignIn,
      ),
    );
  }
}
