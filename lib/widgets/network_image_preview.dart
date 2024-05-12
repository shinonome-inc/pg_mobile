import 'package:flutter/material.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class NetworkImagePreview extends StatefulWidget {
  const NetworkImagePreview({
    Key? key,
    required this.imageUrls,
    required this.selectedIndex,
  }) : super(key: key);

  final List<String> imageUrls;
  final int selectedIndex;

  @override
  State<NetworkImagePreview> createState() => _NetworkImagePreviewState();
}

class _NetworkImagePreviewState extends State<NetworkImagePreview> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              const Spacer(),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  physics: widget.imageUrls.length == 1
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  itemCount: widget.imageUrls.length,
                  itemBuilder: (context, index) {
                    final imageUrl = widget.imageUrls.elementAt(index);
                    return InteractiveViewer(
                      minScale: 0.1,
                      maxScale: 5,
                      child: NetworkImageContainer(imageUrl: imageUrl),
                    );
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
          const CloseButton(),
        ],
      ),
    );
  }
}
