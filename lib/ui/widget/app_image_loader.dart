import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../core/core.dart';

class AppImageLoader extends StatelessWidget {
  const AppImageLoader({
    Key? key,
    required this.imageUrl,
    this.boxFit = BoxFit.fill,
    required this.height,
    required this.width,
    this.fade = true,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final bool fade;

  @override
  Widget build(BuildContext context) {
    // TODO : finalize one method
    return Image.network(
      imageUrl,
      height: height,
      width: width,
      fit: boxFit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          child: const Icon(
           Entypo.emoji_sad,
            size: 24,
          ),
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width,
                  height:  height!-7,
                  color: AppTheme.appRed,
                ),
                const SizedBox(height: 3),
                LinearProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
