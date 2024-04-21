import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/credential_account.dart';

class DebugMyPage extends StatefulWidget {
  final CredentialAccount credentialAccount;

  const DebugMyPage({Key? key, required this.credentialAccount})
      : super(key: key);

  @override
  State<DebugMyPage> createState() => _DebugMyPageState();
}

class _DebugMyPageState extends State<DebugMyPage> {
  late Widget description;

  @override
  void initState() {
    super.initState();
    description = Html(
      data: """
        ${widget.credentialAccount.note}
      """,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.credentialAccount.avatar),
              radius: 28,
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: Text(
              widget.credentialAccount.displayName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: Text(
              '@${widget.credentialAccount.username}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.gray3),
            ),
          ),
          description,
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: Row(
              children: [
                Text(
                  widget.credentialAccount.followingCount.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 2.w),
                Text(
                  'フォロー',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(width: 16.w),
                Text(
                  widget.credentialAccount.followersCount.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 2.w),
                Text(
                  'フォロワー',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
