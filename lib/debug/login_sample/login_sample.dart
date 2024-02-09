import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/login_sample/login_button.dart';


class LoginSample extends StatelessWidget{
  const LoginSample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mastodon Login Example'),
        ),
        body: const Center(
          child: LoginButton(),
        ),
      ),
    );
  }
}