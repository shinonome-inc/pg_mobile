import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';
import 'package:pg_mobile/widgets/status_view.dart';

class DebugHomeTimelinePage extends ConsumerStatefulWidget {
  const DebugHomeTimelinePage({Key? key}) : super(key: key);

  @override
  ConsumerState<DebugHomeTimelinePage> createState() =>
      _DebugHomeTimelinePageState();
}

class _DebugHomeTimelinePageState extends ConsumerState<DebugHomeTimelinePage> {
  late final ScrollController _scrollController;

  void _onPressedNewPost() {
    NavigatorUtil.showNewPostCreateView(context);
  }

  @override
  void initState() {
    final timelineNotifier = ref.read(timelineNotifierProvider.notifier);
    final signedInUserNotifier =
        ref.read(signedInUserNotifierProvider.notifier);
    Future(() async {
      await signedInUserNotifier.fetchUser();
      await timelineNotifier.fetchTimeline();
    });
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      // スクロールして一番下に行ったら、次のページの分のStatusを取得して表示
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        await timelineNotifier.fetchTimeline();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(timelineNotifierProvider);
    final notifier = ref.read(timelineNotifierProvider.notifier);
    final signedInUser = ref.watch(signedInUserNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        leading: state.isLoading
            ? const SizedBox.shrink()
            : NetworkImageContainer(
                padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
                width: 32.h,
                height: 32.h,
                imageUrl: signedInUser.avatar,
                borderRadius: BorderRadius.circular(32.r),
              ),
        title: const Text('Home'),
      ),
      body: state.isLoading && state.statuses.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StatusView(
              statuses: state.statuses,
              controller: _scrollController,
              onRefresh: notifier.onRefresh,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressedNewPost,
        child: const Icon(Icons.add),
      ),
    );
  }
}
