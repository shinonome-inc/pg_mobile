import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/extensions/thread_state_extension.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/providers/thread_notifier.dart';

class DebugThreadPage extends ConsumerStatefulWidget {
  const DebugThreadPage({
    super.key,
    required this.selectedStatus,
  });

  final Status selectedStatus;

  @override
  ConsumerState<DebugThreadPage> createState() => _DebugThreadPageState();
}

class _DebugThreadPageState extends ConsumerState<DebugThreadPage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(threadNotifierProvider.notifier).fetchThreadStatuses(
            widget.selectedStatus.id,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(threadNotifierProvider);
    final notifier = ref.read(threadNotifierProvider.notifier);
    // ancestors, selectedStatus, descendants を結合して1つのリストにまとめる
    final allStatuses = [
      ...state.ancestors,
      widget.selectedStatus,
      ...state.descendants,
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('スレッド'),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async => notifier.reload(widget.selectedStatus.id),
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: allStatuses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return null;
                  },
                ),
              ),
            ),
    );
  }
}
