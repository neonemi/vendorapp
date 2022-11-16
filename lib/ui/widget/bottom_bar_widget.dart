
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vendorapp/ui/widget/triangle_paint.dart';

import '../../core/core.dart';


class BottomItemWidget extends StatelessWidget {
  const BottomItemWidget({
    Key? key,
    required this.isActive,
    required this.image,
    required this.text
  }) : super(key: key);

  final IconData image;
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(text);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          painter:
          TrianglePainter(
            strokeColor:!isActive
                ? AppTheme.appRed
                : AppTheme.appWhite,
            strokeWidth: 3,
            paintingStyle: PaintingStyle.fill,
          ),
          child: const SizedBox(
            height: 20,
            width: 20,
          ),
        ),

        Icon(
          image,
          size: 22,
          color:  AppTheme.appWhite,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 15,
          child: Text(text,style: TextStyle(color: AppTheme.appWhite,fontSize: 12),),
        ),
      ],
    );
  }
}
