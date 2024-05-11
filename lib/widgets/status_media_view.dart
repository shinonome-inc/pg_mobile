import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/models/mastodon/media_attachment.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class StatusMediaView extends StatelessWidget {
  const StatusMediaView({
    Key? key,
    required this.mediaAttachments,
  }) : super(key: key);

  final List<MediaAttachment> mediaAttachments;

  final _fit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(4.r);
    if (mediaAttachments.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: NetworkImageContainer(
                  imageUrl: mediaAttachments[0].url,
                  fit: _fit,
                  borderRadius: borderRadius,
                ),
              ),
              if (mediaAttachments.length > 2) ...{
                SizedBox(height: 8.h),
                Expanded(
                  child: NetworkImageContainer(
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
                    imageUrl: mediaAttachments[1].url,
                    fit: _fit,
                    borderRadius: borderRadius,
                  ),
                ),
                if (mediaAttachments.length > 3) ...{
                  SizedBox(height: 8.h),
                  Expanded(
                    child: NetworkImageContainer(
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
