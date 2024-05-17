import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/image_paths.dart';

class NetworkImageContainer extends StatelessWidget {
  const NetworkImageContainer({
    Key? key,
    required this.imageUrl,
    this.padding,
    this.width,
    this.height,
    this.backgroundColor,
    this.errorImagePath = ImagePaths.error,
    this.boxShape = BoxShape.rectangle,
    this.borderRadius,
    this.fit,
    this.onTap,
  }) : super(key: key);

  final String imageUrl;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final String errorImagePath;
  final Color? backgroundColor;
  final BoxShape boxShape;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: CachedNetworkImage(
          fit: fit,
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: boxShape,
              borderRadius: borderRadius,
              image: DecorationImage(
                fit: fit,
                image: imageProvider,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              shape: boxShape,
              borderRadius: borderRadius,
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
