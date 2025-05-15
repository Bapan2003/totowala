import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../theme/colors.dart';

class AppPinTheme  {

  /// Pin Theme
  static PinTheme pinTheme({Color? borderColor, double height = 50}) {
    return PinTheme(
      activeColor: borderColor ,
      inactiveColor: AppColors.keypadColor.withOpacity(0.5) ,
      selectedColor: borderColor ,
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(8),
      fieldHeight: height,
      fieldWidth: height,
      selectedFillColor: AppColors.transparent ,
      activeFillColor: borderColor ,
      inactiveFillColor: AppColors.transparent,
    );
  }
}
