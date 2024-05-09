import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/image_paths.dart';
import 'package:pg_mobile/util/navigator_util.dart';

class NetworkImageContainer extends StatelessWidget {
  const NetworkImageContainer({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.backgroundColor,
    this.errorImagePath = ImagePaths.error,
    this.boxShape = BoxShape.rectangle,
    this.fit,
    this.onTap,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final String errorImagePath;
  final Color? backgroundColor;
  final BoxShape boxShape;
  final BoxFit? fit;
  final void Function()? onTap;

  void _onTap(BuildContext context) {
    NavigatorUtil.showNetworkImagePreview(context, imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => _onTap(context),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: boxShape,
        ),
        child: CachedNetworkImage(
          fit: fit,
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: boxShape,
              image: DecorationImage(
                fit: fit,
                image: imageProvider,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              shape: boxShape,
              image: DecorationImage(
                fit: fit,
                image: AssetImage(errorImagePath),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
