import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/util/env_mixin.dart';
import 'package:pg_mobile/repository/mastdon_repository.dart';

class LoginButton extends StatelessWidget with EnvMixin {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await MastdonRepository.signIn();
      },
      child: const Text('Sign in with Mastodon'),
    );
  }
}
