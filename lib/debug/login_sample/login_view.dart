import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/debug_page.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/repository/secure_storage_repository.dart';
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
      ..setNavigationDelegate(
          NavigationDelegate(onPageFinished: (String uri) async {
        final url = Uri.parse(uri);
        if (url.queryParameters['code'] != null) {
          final accessToken = await MastodonRepository.instance.signIn(url);
          if (accessToken != null) {
            MastodonRepository.instance.set(accessToken);
            await SecureStorageRepository.writeToken(accessToken);
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DebugPage()),
            );
          }
        }
      }))
      ..loadRequest(Uri.parse(MastodonRepository.instance.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
