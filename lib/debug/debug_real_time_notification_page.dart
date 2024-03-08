import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(MastodonRepository.instance.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            final uri = Uri.parse(url);
            if (uri.queryParameters['code'] != null) {
              final accessToken = await MastodonRepository.instance.signIn(uri);
              if (accessToken != null) {
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DebugRealTimeNotificationPage(accessToken: accessToken),
                  ),
                );
              }
            }
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("サインイン"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              enableDrag: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: LoginView(
                    controller: controller,
                  ),
                );
              },
            );
          },
          child: const Text("サインインする"),
        ),
      ),
    );
  }
}

class DebugRealTimeNotificationPage extends StatefulWidget {
  final String accessToken;

  const DebugRealTimeNotificationPage({Key? key, required this.accessToken})
      : super(key: key);

  @override
  State<DebugRealTimeNotificationPage> createState() =>
      _DebugRealTimeNotificationPageState();
}

class _DebugRealTimeNotificationPageState
    extends State<DebugRealTimeNotificationPage> {
  List<String> nameList = [];
  late final WebSocketChannel channel;
  @override
  void initState() {
    super.initState();
    // WebSocketの接続を行う
    channel = IOWebSocketChannel.connect(
      Uri.parse(
          "wss://community.4nonome.com/api/v1/streaming/?stream=user:notification&access_token=${widget.accessToken}"),
    );
    // リアルタイムで返ってきた通知を処理する
    channel.stream.listen((data) {
      Map<String, dynamic> body = json.decode(data);
      Map<String, dynamic> payloadData = json.decode(body["payload"]);
      if (mounted) {
        setState(() {
          nameList.add(payloadData['account']['username']);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("通知リスト"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: nameList.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(nameList[index]);
        },
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  final WebViewController controller;
  const LoginView({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
