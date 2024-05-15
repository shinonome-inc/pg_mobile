import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/debug/debug_loding_view.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/util/navigator_util.dart';
import 'package:pg_mobile/widgets/reply_to_status_view.dart';

class NewPostModalBottomSheet extends StatefulWidget {
  const NewPostModalBottomSheet({
    Key? key,
    required this.replyToStatus,
  }) : super(key: key);

  final Status? replyToStatus;

  @override
  State<NewPostModalBottomSheet> createState() =>
      _NewPostModalBottomSheetState();
}

class _NewPostModalBottomSheetState extends State<NewPostModalBottomSheet> {
  final Color _foregroundColor = AppColors.gray3;
  late TextEditingController _controller;
  bool _isLoading = false;
  static const _maxTextCount = 500;
  int _remainingCount = _maxTextCount;

  Future<void> _onPressedSend() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      await MastodonRepository.instance.postNewStatus(
        text: _controller.text,
        mediaIds: [],
        poll: [],
        inReplyToId: widget.replyToStatus?.id,
      );
    } catch (e) {
      throw Exception('Failed to send: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const minChildSize = 0.24;
    final deviceHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: minChildSize,
      initialChildSize: keyboardHeight == 0
          ? minChildSize
          : (200.h + keyboardHeight) / deviceHeight,
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
                        ReplyToStatusView(status: widget.replyToStatus!),
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
            if (_isLoading) const DebugLoadingView(),
          ],
        );
      },
    );
  }
}
