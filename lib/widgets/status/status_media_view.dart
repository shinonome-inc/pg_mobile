import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/extensions/media_attachment_extension.dart';
import 'package:pg_mobile/models/mastodon/media_attachment.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';
import 'package:pg_mobile/widgets/network_video_thumbnail_view.dart';

class StatusMediaView extends StatelessWidget {
  const StatusMediaView({
    Key? key,
    required this.mediaAttachments,
  }) : super(key: key);

  final List<MediaAttachment> mediaAttachments;

  final _fit = BoxFit.cover;

  List<String> get _imageUrls =>
      [for (var attachment in mediaAttachments) attachment.url];

  void _onTapImage(BuildContext context, int selectedIndex) {
    NavigatorUtil.showNetworkImagePreview(
      context: context,
      imageUrls: _imageUrls,
      selectedIndex: selectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mediaAttachments.isEmpty) {
      return const SizedBox.shrink();
    }
    if (mediaAttachments.isGifv || mediaAttachments.isVideo) {
      return SizedBox(
        width: double.infinity,
        child: NetworkVideoThumbnailView(
          url: mediaAttachments.first.url,
          isGifv: mediaAttachments.isGifv,
        ),
      );
    }
    final borderRadius = BorderRadius.circular(4.r);
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: NetworkImageContainer(
                  onTap: () => _onTapImage(context, 0),
                  imageUrl: mediaAttachments[0].url,
                  fit: _fit,
                  borderRadius: borderRadius,
                ),
              ),
              if (mediaAttachments.length > 2) ...{
                SizedBox(height: 8.h),
                Expanded(
                  child: NetworkImageContainer(
                    onTap: () => _onTapImage(context, 2),
                    imageUrl: mediaAttachments[2].url,
                    fit: _fit,
                    borderRadius: borderRadius,
                  ),
                ),
              }
            ],
          ),
        ),
        if (mediaAttachments.length > 1) ...{
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: NetworkImageContainer(
                    onTap: () => _onTapImage(context, 1),
                    imageUrl: mediaAttachments[1].url,
                    fit: _fit,
                    borderRadius: borderRadius,
                  ),
                ),
                if (mediaAttachments.length > 3) ...{
                  SizedBox(height: 8.h),
                  Expanded(
                    child: NetworkImageContainer(
                      onTap: () => _onTapImage(context, 3),
                      imageUrl: mediaAttachments[3].url,
                      fit: _fit,
                      borderRadius: borderRadius,
                    ),
                  ),
                }
              ],
            ),
          ),
        }
      ],
    );
  }
}
