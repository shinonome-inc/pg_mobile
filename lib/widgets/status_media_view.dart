import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/models/mastodon/media_attachment.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class StatusMediaView extends StatefulWidget {
  const StatusMediaView({
    Key? key,
    required this.mediaAttachments,
  }) : super(key: key);

  final List<MediaAttachment> mediaAttachments;

  @override
  State<StatusMediaView> createState() => _StatusMediaViewState();
}

class _StatusMediaViewState extends State<StatusMediaView> {
  final _fit = BoxFit.cover;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(4.r);
    if (widget.mediaAttachments.isEmpty) {
      return const SizedBox.shrink();
    }
    final imageUrls = [
      for (var attachment in widget.mediaAttachments) attachment.url
    ];
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: NetworkImageContainer(
                  onTap: () {
                    NavigatorUtil.showNetworkImagePreview(
                      context: context,
                      controller: _controller,
                      imageUrls: imageUrls,
                    );
                  },
                  imageUrl: widget.mediaAttachments[0].url,
                  fit: _fit,
                  borderRadius: borderRadius,
                ),
              ),
              if (widget.mediaAttachments.length > 2) ...{
                SizedBox(height: 8.h),
                Expanded(
                  child: NetworkImageContainer(
                    onTap: () {
                      NavigatorUtil.showNetworkImagePreview(
                        context: context,
                        controller: _controller,
                        imageUrls: imageUrls,
                      );
                    },
                    imageUrl: widget.mediaAttachments[2].url,
                    fit: _fit,
                    borderRadius: borderRadius,
                  ),
                ),
              }
            ],
          ),
        ),
        if (widget.mediaAttachments.length > 1) ...{
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: NetworkImageContainer(
                    onTap: () {
                      NavigatorUtil.showNetworkImagePreview(
                        context: context,
                        controller: _controller,
                        imageUrls: imageUrls,
                      );
                    },
                    imageUrl: widget.mediaAttachments[1].url,
                    fit: _fit,
                    borderRadius: borderRadius,
                  ),
                ),
                if (widget.mediaAttachments.length > 3) ...{
                  SizedBox(height: 8.h),
                  Expanded(
                    child: NetworkImageContainer(
                      onTap: () {
                        NavigatorUtil.showNetworkImagePreview(
                          context: context,
                          controller: _controller,
                          imageUrls: imageUrls,
                        );
                      },
                      imageUrl: widget.mediaAttachments[3].url,
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
