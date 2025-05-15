
import 'package:flutter/cupertino.dart';

import 'colors.dart';

///   Text Style

TextStyle kTextStyleCustomColor(Color color, double size, bool isBold,
    {bool? isUnderline, bool? cairo}) {
  var underline = false;
  if (isUnderline != null) {
    underline = isUnderline;
  }
  return TextStyle(
    fontSize: size,
    fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    color: color,
    fontFamily: cairo != null ? 'Cairo' : 'Poppins',
    decoration: underline ? TextDecoration.underline : null,
    decorationColor: color,
  );
}

TextStyle kTextStyleColor800(
    {Color color=AppColors.black,double size=14,bool isUnderline=false, bool cairo=false,bool isBold=false}) {

  return TextStyle(
      fontSize: size,
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
      color: color,
      fontFamily: cairo  ? 'Cairo' : 'Poppins',
      decoration: isUnderline ? TextDecoration.underline : null);
}

TextStyle kTextStyleColor600(
    {Color color=AppColors.black,double size=14,bool isUnderline=false, bool cairo=false,bool isBold=false}) {

  return TextStyle(
      fontSize: size,
      fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
      color: color,
      fontFamily: cairo  ? 'Cairo' : 'Poppins',
      decoration: isUnderline ? TextDecoration.underline : null);
}

TextStyle kTextStyleColor500(
    {Color color=AppColors.black,double size=14,bool isUnderline=false, bool cairo=false,bool isBold=true}) {
  return TextStyle(
      fontSize: size,
      fontWeight: isBold ? FontWeight.w500 : FontWeight.w400,
      color: color,
      fontFamily: cairo  ? 'Cairo' : 'Poppins',
      decoration: isUnderline ? TextDecoration.underline : null);
}

TextStyle kTextStyleColor700(
    {Color color=AppColors.black,double size=14,bool isUnderline=false, bool cairo=false,bool isBold=false}) {

  return TextStyle(
      fontSize: size,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      color: color,
      fontFamily: cairo  ? 'Cairo' : 'Poppins',
      decoration: isUnderline ? TextDecoration.underline : null);
}

TextStyle kTextStyleCustomSemiBold({Color color=AppColors.black, double size=14, bool cairo=false}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: color,
    fontFamily: cairo  ? 'Cairo' : 'Poppins',
  );
}

TextStyle kTextStyleCustomSubText(
    {Color color=AppColors.black, double size=14, bool isBold=false,bool cairo=false}) {
  return TextStyle(
    color: color,
    fontWeight: isBold ? FontWeight.w600 : FontWeight.w300,
    fontSize: size,
    fontFamily: cairo  ? 'Cairo' : 'Poppins',
  );
}
