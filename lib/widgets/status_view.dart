import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';
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
      child: Scrollbar(
        controller: controller,
        child: ListView.builder(
          controller: controller,
          itemCount: statuses.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == statuses.length) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.white,
                ),
              );
            }
            final status = statuses[index];
            return StatusItem(
              status: status.reblog == null ? status : status.reblog!,
              reblogAccount: status.reblog == null ? null : status.account,
            );
          },
        ),
      ),
    );
  }
}
