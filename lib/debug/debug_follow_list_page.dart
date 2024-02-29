import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/follow_model.dart';

class DebugFollowListPage extends StatelessWidget {
  final List<FollowModel> followModelList;
  const DebugFollowListPage({Key? key, required this.followModelList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("フォロー一覧画面"),
      ),
      body: ListView.builder(
        itemCount: followModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 16),
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(followModelList[index].avatarUrl),
                    radius: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        followModelList[index].displayName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "@${followModelList[index].username}",
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
