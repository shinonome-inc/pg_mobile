import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/widgets/new_post_modal_bottom_sheet.dart';
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
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const NewPostModalBottomSheet();
      },
    );
  }

  // スクロールして一番下に行ったら、次のページの分のStatusを取得して表示
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        await ref.read(timelineProvider.notifier).fetchTimeline();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(timelineProvider);
    final notifier = ref.read(timelineProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: state.isLoading && state.statuses.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                StatusView(
                  statuses: state.statuses,
                  controller: _scrollController,
                  onRefresh: notifier.onRefresh,
                ),
                const Column(
                  children: [
                    Spacer(),
                    NewPostModalBottomSheet(),
                  ],
                ),
              ],
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _onPressedNewPost,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
