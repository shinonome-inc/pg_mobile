import 'package:flutter/material.dart';

class PgMobileDefaultButton extends StatelessWidget {
  const PgMobileDefaultButton({
    required this.backgroundColor,
    required this.onPressed,
    required this.buttonText,
    required this.buttonTextStyle,
    required this.buttonHeight,
    required this.buttonWidth,
    super.key,
  });
  final Color backgroundColor;
  final void Function() onPressed;
  final String buttonText;
  final TextStyle buttonTextStyle;
  final double buttonHeight;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
