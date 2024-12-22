import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/pages/timeline/timeline_notifier.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/widgets/status/status_item.dart';

class TimelinePage extends ConsumerStatefulWidget {
  const TimelinePage({super.key});

  @override
  ConsumerState createState() => _StatusListPageState();
}

class _StatusListPageState extends ConsumerState<TimelinePage> {
  final ScrollController _controller = ScrollController();

  Future<void> _onTapBoost(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.onTapBoost(status);
  }

  Future<void> _onTapFavorite(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.onTapFavorite(status);
  }

  Future<void> _pinToProfile(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.pinStatusToProfile(status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  Future<void> _unpinToProfile(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.unpinStatusToProfile(status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  void _deleteAndReturnToDraft() {
    // TODO: 削除して下書きに戻す
    NavigatorUtil.popScreen(context);
  }

  Future<void> _delete(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.deleteStatus(status);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  Future<void> _mute(Status status) async {
    final notifier = ref.read(timelineNotifierProvider.notifier);
    await notifier.muteAccount(status.account);
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  void _block() {
    // TODO: ブロック
    NavigatorUtil.popScreen(context);
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      await ref.read(timelineNotifierProvider.notifier).fetchTimeline();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(timelineNotifierProvider);
    final notifier = ref.read(timelineNotifierProvider.notifier);
    final signedInUser = ref.read(signedInUserNotifierProvider);
    return Scaffold(
      backgroundColor: AppColors.gray1,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8.w),
            const Icon(Icons.home),
            SizedBox(width: 8.w),
            const Text('ホーム'),
            IconButton(
              onPressed: () {
                // TODO: タイムラインの種類を切り替える。
              },
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
          ],
        ),
      ),
      body: state.isLoading && state.statuses.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: notifier.onRefresh,
              child: Scrollbar(
                controller: _controller,
                child: ListView.builder(
                  controller: _controller,
                  itemCount: state.statuses.length,
                  itemBuilder: (BuildContext context, int index) {
                    final status = state.statuses[index];
                    final isSignedInUser = signedInUser != null &&
                        status.account.id == signedInUser.id;
                    return StatusItem(
                      status: status,
                      signedInUser: signedInUser,
                      onTapBoost: () => _onTapBoost(status),
                      onTapFavorite: () => _onTapFavorite(status),
                      onPinToProfile: () => _pinToProfile,
                      onUnpinToProfile: () => _unpinToProfile,
                      onDeleteAndReturnToDraft: () =>
                          isSignedInUser ? _deleteAndReturnToDraft : null,
                      onDelete: () => isSignedInUser ? _delete : null,
                      onMute: () => _mute,
                      onBlock: _block,
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigatorUtil.showNewPostCreateView(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
