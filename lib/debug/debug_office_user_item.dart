import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pg_mobile/models/office_user.dart';

class DebugOfficeUserItem extends StatelessWidget {
  const DebugOfficeUserItem({Key? key, required this.user}) : super(key: key);

  final OfficeUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(
              (Random().nextDouble() * 0xFFFFFF).toInt() << 0,
            ).withOpacity(1.0),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Text(
            user.name[0],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        Text(
          '${user.name} \n@${user.id}',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
