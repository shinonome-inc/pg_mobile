import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/mastodon_user.dart';

class DebugFollowListPage extends StatelessWidget {
  final List<MastodonUser> followList;
  const DebugFollowListPage({
    Key? key,
    required this.followList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("フォロー一覧画面"),
      ),
      body: ListView.builder(
        itemCount: followList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 16),
                  CircleAvatar(
                    backgroundImage: NetworkImage(followList[index].avatar),
                    radius: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        followList[index].displayName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "@${followList[index].username}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.gray3),
                      )
                    ],
                  )
                ],
              ),
              const Divider(
                height: 5,
                thickness: 1,
                color: AppColors.gray3,
              )
            ],
          );
        },
      ),
    );
  }
}
