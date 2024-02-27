import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';

class DebugLoadingView extends StatelessWidget {
  const DebugLoadingView({Key? key}) : super(key: key);

  static const double _sigma = 5.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _sigma,
          sigmaY: _sigma,
        ),
        child: Center(
          child: Theme.of(context).platform == TargetPlatform.iOS
              ? const CupertinoActivityIndicator()
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
