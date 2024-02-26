import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/models/follower_model.dart';

class DebugFollowerListPage extends StatelessWidget {
  final List<FollowerModel> followerModelList;
  const DebugFollowerListPage({Key? key, required this.followerModelList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("フォロワー一覧画面"),
      ),
      body: ListView.builder(
        itemCount: followerModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 16),
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(followerModelList[index].avatarUrl),
                    radius: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        followerModelList[index].displayName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "@${followerModelList[index].username}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.gray3,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 5,
                color: AppColors.gray3,
                thickness: 1,
              )
            ],
          );
        },
      ),
    );
  }
}
