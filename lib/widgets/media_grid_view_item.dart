import 'package:flutter/material.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class MediaGridViewItem extends StatelessWidget {
  const MediaGridViewItem({
    super.key,
    required this.status,
  });

  final Status status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: 画像をタップした際の処理を追加する。
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          NetworkImageContainer(
            fit: BoxFit.cover,
            imageUrl: status.mediaAttachments.first.url,
          ),
          if (status.mediaAttachments.length > 1)
            const Padding(
              padding: EdgeInsets.only(top: 4.0, right: 4.0),
              child: Icon(Icons.photo_library),
            ),
        ],
      ),
    );
  }
}
