

import 'package:flutter/material.dart';
import 'package:totowala/core/theme/colors.dart';

class AppDecoration{

  //  Box Decoration
  static BoxDecoration kCustomBoxDecorationWithShadow(
      double radius, Color bgColor, Color borderColor, Color shadowColor,{isCircle=false}) {
    return BoxDecoration(
      borderRadius: isCircle?null:BorderRadius.circular(radius),
      border: Border.all(color: borderColor),
      color: bgColor,
      shape: isCircle?BoxShape.circle:BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(0.1),
          blurRadius: 12,
          offset: const Offset(0, 6),
        )
      ],
    );
  }

  static BoxDecoration kCustomBoxDecoration(
      double radius, Color bgColor, Color borderColor,{bool isCircle=false}) {
    return BoxDecoration(
      borderRadius:  isCircle?null:BorderRadius.circular(radius),
      border: Border.all(color: borderColor),
      color: bgColor,
      shape: isCircle?BoxShape.circle:BoxShape.rectangle,
    );
  }

  static BoxDecoration kCustomBoxDecorationBorder(
      double radius, Color bgColor, Color borderColor, double border) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: border),
      color: bgColor,
    );
  }

  static BoxDecoration kCustomBoxUnderLineDecoration(Color bgColor, Color borderColor) {
    return BoxDecoration(
      border: Border(bottom: BorderSide(color: borderColor)),
      color: bgColor,
    );
  }

  static BoxDecoration kKeyboardDecoration({String? from}) {
    return BoxDecoration(
      color:  AppColors.transparent,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: from == null ? AppColors.keypadColor : AppColors.transparent),
    );
  }

}