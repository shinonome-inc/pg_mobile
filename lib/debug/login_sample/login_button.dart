import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/login_sample/login_view.dart';
import 'package:pg_mobile/util/env_mixin.dart';

class LoginButton extends StatefulWidget with EnvMixin {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          enableDrag: true,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const LoginView(),
            );
          },
        );
      },
      child: const Text('Sign in with Mastodon'),
    );
  }
}
