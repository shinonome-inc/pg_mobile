import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class StatusLinkPreview extends StatefulWidget {
  const StatusLinkPreview({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<StatusLinkPreview> createState() => _StatusLinkPreviewState();
}

class _StatusLinkPreviewState extends State<StatusLinkPreview> {
  late WebInfo _info;
  bool _isLoading = false;

  Future<void> _initialize() async {
    setState(() {
      _isLoading = true;
    });
    final info = await LinkPreview.scrapeFromURL(widget.url);
    setState(() {
      _info = info;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () async {
        await launchUrl(Uri.parse(widget.url));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gray2,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 104.h,
              height: 104.h,
              child: Image.network(
                _info.image,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _info.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _info.domain,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.gray4,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
