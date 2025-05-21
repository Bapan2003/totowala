import 'package:flutter/material.dart';
import 'package:totowala/core/decoration/app_decoration.dart';

import '../../../../core/theme/colors.dart';

class PickupDropLine extends StatefulWidget {
  const PickupDropLine({super.key});

  @override
  State<PickupDropLine> createState() => _PickupDropLineState();
}

class _PickupDropLineState extends State<PickupDropLine> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        children: [
          // Green dot for pickup
          Container(
            width: 10,
            height: 10,
            decoration: AppDecoration.kCustomBoxDecoration(12, AppColors.greenColor, AppColors.greenColor,isCircle: true),
          ),
          // Spacer line
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                10, // Adjust count based on total height
                    (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    width: 2,
                    height: 2,
                    decoration: BoxDecoration(
                      color: AppColors.grey400,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Red dot for drop
          Container(
            width: 10,
            height: 10,
            decoration: AppDecoration.kCustomBoxDecoration(12, AppColors.redColor, AppColors.redColor,isCircle: true),

          ),
        ],
      ),
    );
  }
}
