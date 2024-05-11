import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/widgets/status_item.dart';

class StatusView extends StatelessWidget {
  const StatusView({
    Key? key,
    required this.statuses,
    required this.controller,
    required this.onRefresh,
  }) : super(key: key);

  final List<Status> statuses;
  final ScrollController? controller;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: controller,
        itemCount: statuses.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == statuses.length) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return StatusItem(status: statuses[index]);
        },
      ),
    );
  }
}
