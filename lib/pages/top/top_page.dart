import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/constants/border_radiuses.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:pg_mobile/pages/top/top_notifier.dart';
import 'package:pg_mobile/pages/top/top_view.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/util/web_view_util.dart';
import 'package:pg_mobile/widgets/scrollable_modal_bottom_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TopPage extends ConsumerStatefulWidget {
  const TopPage({super.key});

  @override
  ConsumerState createState() => _TopPageState();
}

class _TopPageState extends ConsumerState<TopPage> {
  late WebViewController _controller;

  Future<void> _onTapSignIn(double webViewHeight) async {
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
            height: webViewHeight,
            child: WebViewWidget(controller: _controller),
          ),
        );
      },
    );
  }

  Future<void> _onPageFinished(String url) async {
    final notifier = ref.read(topNotifierProvider.notifier);
    final webViewHeight = await WebViewUtil.calculateWebViewHeight(_controller);
    notifier.setWebViewHeight(webViewHeight);
    final accessToken = await notifier.signInFromUrl(url);
    if (accessToken == null) return;
    if (!mounted) return;
    context.pushReplacement(AppPage.timeline.path);
  }

  void _initializeWebViewController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(onPageFinished: _onPageFinished),
        )
        ..loadRequest(Uri.parse(MastodonRepository.authorizeUrl));
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(topNotifierProvider);
    return Scaffold(
      body: TopView(
        onTapSignIn: () => _onTapSignIn(state.webViewHeight),
      ),
    );
  }
}
