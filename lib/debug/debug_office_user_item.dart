import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/models/office_user.dart';

class DebugOfficeUserItem extends StatelessWidget {
  const DebugOfficeUserItem({Key? key, required this.user}) : super(key: key);

  final OfficeUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user.imageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '${user.name} \n@${user.id}',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
