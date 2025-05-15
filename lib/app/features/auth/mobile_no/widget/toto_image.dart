import 'package:flutter/material.dart';

import '../../../../../core/library/images.dart';
import '../../../../../core/theme/colors.dart';

class TotoImage extends StatelessWidget {
  const TotoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Circular shadow
        Positioned(
          bottom: 55,
          left: 15,
          right: 15,
          child: Container(
            width: 300,
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
          height: 300,
          width: double.infinity,
        ),
      ],
    );
  }
}
