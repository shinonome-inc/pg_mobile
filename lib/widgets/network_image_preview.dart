import 'package:flutter/material.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class NetworkImagePreview extends StatelessWidget {
  const NetworkImagePreview({
    Key? key,
    required this.controller,
    required this.imageUrls,
  }) : super(key: key);

  final PageController controller;
  final List<String> imageUrls;

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
                  controller: controller,
                  physics: imageUrls.length == 1
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  itemBuilder: (context, index) {
                    final imageUrl =
                        imageUrls.elementAt(index % imageUrls.length);
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
