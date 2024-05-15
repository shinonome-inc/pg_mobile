import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/debug/debug_loding_view.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/widgets/reply_to_status_view.dart';

class NewPostModalBottomSheet extends ConsumerStatefulWidget {
  const NewPostModalBottomSheet({
    Key? key,
    required this.replyToStatus,
  }) : super(key: key);

  final Status? replyToStatus;

  @override
  ConsumerState<NewPostModalBottomSheet> createState() =>
      _NewPostModalBottomSheetState();
}

class _NewPostModalBottomSheetState
    extends ConsumerState<NewPostModalBottomSheet> {
  final Color _foregroundColor = AppColors.gray3;
  static const _maxTextCount = 500;

  final _replyToStatusViewKey = GlobalKey();
  late TextEditingController _controller;
  int _remainingCount = _maxTextCount;
  double _replyToStatusViewHeight = 0.0;

  Future<void> _onPressedSend() async {
    final notifier = ref.read(timelineProvider.notifier);
    await notifier.postStatus(
      text: _controller.text,
      inReplyToId: widget.replyToStatus?.id,
    );
    _controller.clear();
    if (!mounted) return;
    NavigatorUtil.popScreen(context);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.replyToStatus?.mentionsText,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _replyToStatusViewKey.currentContext?.findRenderObject()
          as RenderBox?;
      setState(() {
        _replyToStatusViewHeight = box == null ? 0.0 : box.size.height + 16.h;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(timelineProvider.select(
      (value) => value.isLoading,
    ));
    const minChildSize = 0.24;
    final deviceHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final initialChildSize =
        (_replyToStatusViewHeight + 200.h + keyboardHeight) / deviceHeight;
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: minChildSize,
      initialChildSize: initialChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.gray1,
                border: Border(
                  top: BorderSide(
                    color: _foregroundColor,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Column(
                    children: [
                      if (widget.replyToStatus != null) ...{
                        ReplyToStatusView(
                          key: _replyToStatusViewKey,
                          status: widget.replyToStatus!,
                        ),
                        SizedBox(height: 16.h),
                      },
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'メッセージを入力',
                          hintStyle: const TextStyle(color: AppColors.gray3),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _foregroundColor,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _remainingCount =
                                _maxTextCount - _controller.text.length;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt_outlined),
                            color: _foregroundColor,
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image_outlined),
                            color: _foregroundColor,
                          ),
                          const Spacer(),
                          Text(
                            '残り$_remainingCount文字',
                            style: TextStyle(color: _foregroundColor),
                          ),
                          IconButton(
                            onPressed: _controller.text.isEmpty
                                ? () {}
                                : _onPressedSend,
                            icon: const Icon(Icons.send),
                            color: _controller.text.isEmpty
                                ? _foregroundColor
                                : AppColors.accent,
                          ),
                        ],
                      ),
                      SizedBox(height: keyboardHeight),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading) const DebugLoadingView(),
          ],
        );
      },
    );
  }
}
