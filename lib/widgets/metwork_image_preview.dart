import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';

class NetworkImagePreview extends StatelessWidget {
  const NetworkImagePreview({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: IconButton.styleFrom(
              backgroundColor: AppColors.gray1A80,
            ),
            icon: const Icon(Icons.close),
          ),
          const Spacer(),
          InteractiveViewer(
            minScale: 0.1,
            maxScale: 5,
            child: CachedNetworkImage(imageUrl: imageUrl),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
