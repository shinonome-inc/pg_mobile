import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/states/thread_state.dart';
import 'package:pg_mobile/providers/thread_notifier.dart';
import 'package:pg_mobile/widgets/status_item.dart';

class DebugThreadPage extends ConsumerStatefulWidget {
  const DebugThreadPage({
    Key? key,
    required this.selectedStatus,
  }) : super(key: key);

  final Status selectedStatus;

  @override
  ConsumerState<DebugThreadPage> createState() => _DebugThreadPageState();
}

class _DebugThreadPageState extends ConsumerState<DebugThreadPage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(threadProvider.notifier).fetchThreadStatuses(
            widget.selectedStatus.id,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(threadProvider);
    final notifier = ref.read(threadProvider.notifier);
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: state.ancestors.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return StatusItem(
                            status: state.ancestors.elementAt(index),
                          );
                        },
                      ),
                      StatusItem(
                        status: widget.selectedStatus,
                        showDetails: true,
                      ),
                      ListView.builder(
                        itemCount: state.descendants.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return StatusItem(
                            status: state.descendants.elementAt(index),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
