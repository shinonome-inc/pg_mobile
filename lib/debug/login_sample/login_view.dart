import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/debug_page.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (String url) async {
          final uri = Uri.parse(url);
          final code = uri.queryParameters['code'];
          if (code == null) return;
          final accessToken =
              await MastodonRepository.instance.obtainToken(code);
          if (accessToken == null) return;
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DebugPage()),
          );
        },
      ))
      ..loadRequest(Uri.parse(MastodonRepository.instance.authorizeUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
