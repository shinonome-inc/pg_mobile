import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/widgets/search_bar_widget.dart';
import 'package:pg_mobile/widgets/status_view.dart';

class DebugHomeTimelinePage extends ConsumerStatefulWidget {
  const DebugHomeTimelinePage({Key? key}) : super(key: key);

  @override
  ConsumerState<DebugHomeTimelinePage> createState() =>
      _DebugHomeTimelinePageState();
}

class _DebugHomeTimelinePageState extends ConsumerState<DebugHomeTimelinePage> {
  late final ScrollController _scrollController;

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

  Future<void> _onRefresh() async {
    final notifier = ref.read(timelineProvider.notifier);
    notifier.reset();
    notifier.fetchTimeline();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(timelineProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: SearchBarWidget(),
        ),
      ),
      body: state.isLoading && state.statuses.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StatusView(
              statuses: state.statuses,
              controller: _scrollController,
              onRefresh: _onRefresh,
            ),
    );
  }
}
