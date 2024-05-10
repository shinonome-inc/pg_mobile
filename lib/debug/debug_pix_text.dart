import 'package:flutter/material.dart';

class DebugPIXText extends StatelessWidget {
  const DebugPIXText({
    Key? key,
    required this.title,
    required this.pix,
  }) : super(key: key);

  final String title;
  final int pix;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: '$title :',
          ),
          TextSpan(
            text: pix.toString().padLeft(8),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: ' SPIX',
          ),
        ],
      ),
    );
  }
}
