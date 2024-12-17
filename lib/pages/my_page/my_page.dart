import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/extensions/build_context_extension.dart';
import 'package:pg_mobile/models/enums/app_page.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/widgets/linkable_text.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(signedInUserNotifierProvider);
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NetworkImageContainer(
                  imageUrl: user.header,
                  aspectRatio: 375 / 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 56.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName,
                        style: context.textTheme.titleLargeBold,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '@${user.username}',
                        style: context.textTheme.bodyMediumNormal?.copyWith(
                          color: AppColors.gray4,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      LinkableText(
                        user.note,
                        onTapMention: (value) {},
                        onTapHashtag: (value) {},
                      ),
                      SizedBox(width: 16.h),
                      Row(
                        children: [
                          _UserActivityCountItem(
                            onTap: () {
                              context.push(AppPage.timeline.path);
                            },
                            count: user.statusesCount,
                            label: '投稿',
                          ),
                          SizedBox(width: 16.w),
                          _UserActivityCountItem(
                            onTap: () {
                              context.push(AppPage.followingList.path);
                            },
                            count: user.statusesCount,
                            label: 'フォロー',
                          ),
                          SizedBox(width: 16.w),
                          _UserActivityCountItem(
                            onTap: () {
                              context.push(AppPage.followerList.path);
                            },
                            count: user.statusesCount,
                            label: 'フォロワー',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
          Positioned(
            top: 160.h,
            left: 16.0,
            child: NetworkImageContainer(
              imageUrl: user.avatar,
              padding: EdgeInsets.all(4.h),
              backgroundColor: AppColors.gray2,
              width: 88.h,
              height: 88.h,
              boxShape: BoxShape.circle,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(AppPage.createStatus.path);
        },
      ),
    );
  }
}

class _UserActivityCountItem extends StatelessWidget {
  const _UserActivityCountItem({
    required this.onTap,
    required this.count,
    required this.label,
  });

  final void Function() onTap;
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            count.toString(),
            style: context.textTheme.bodyMediumBold,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: context.textTheme.bodySmallNormal?.copyWith(
              color: AppColors.gray4,
            ),
          ),
        ],
      ),
    );
  }
}
