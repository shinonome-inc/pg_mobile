import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/constants/app_colors.dart';
import 'package:pg_mobile/constants/image_paths.dart';
import 'package:pg_mobile/widgets/network_image_container.dart';

class DebugCachedNetworkImagePage extends StatelessWidget {
  const DebugCachedNetworkImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('画像のキャッシュ化'),
      ),
      body: Stack(
        children: [
          NetworkImageContainer(
            imageUrl:
                'https://cdn.pixabay.com/photo/2016/11/29/09/44/countryside-1868781_1280.jpg',
            width: double.infinity,
            height: 160.h,
            errorImagePath: ImagePaths.error,
            backgroundColor: AppColors.white,
            fit: BoxFit.cover,
          ),
          Container(
            width: 96.w,
            height: 96.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16.w, top: 96.h),
            decoration: const BoxDecoration(
              color: AppColors.gray1,
              shape: BoxShape.circle,
            ),
            child: NetworkImageContainer(
              imageUrl:
                  'https://3.bp.blogspot.com/-n0PpkJL1BxE/VCIitXhWwpI/AAAAAAAAmfE/xLraJLXXrgk/s800/animal_hamster.png',
              width: 80.w,
              height: 80.w,
              errorImagePath: ImagePaths.error,
              backgroundColor: AppColors.white,
              boxShape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
