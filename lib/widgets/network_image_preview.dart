import 'package:flutter/material.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class NetworkImagePreview extends StatelessWidget {
  const NetworkImagePreview({
    Key? key,
    required this.imageUrls,
    required this.selectedIndex,
  }) : super(key: key);

  final List<String> imageUrls;
  final int selectedIndex;

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
                  controller: PageController(initialPage: selectedIndex),
                  physics: imageUrls.length == 1
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    final imageUrl = imageUrls.elementAt(index);
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
