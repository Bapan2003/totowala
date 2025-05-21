import 'package:flutter/material.dart';

import '../../../../../core/library/images.dart';
import '../../../../../core/theme/colors.dart';

class TotoImage extends StatelessWidget {
  const TotoImage({super.key});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double imgHeight=height*0.3;
    double bottomHeight=height*0.065;
    return Stack(
      alignment: Alignment.center,
      children: [
        // Circular shadow
        Positioned(
          bottom: bottomHeight,
          left: 15,
          right: 15,
          child: Container(
            width: imgHeight,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: Offset(0, 8),
                ),
              ],
            ),
          ),
        ),

        // Image
        Image.asset(
          AppImages.totologo,
          color: AppColors.blueColor,
          height: imgHeight,
          width: double.infinity,
        ),
      ],
    );
  }
}
