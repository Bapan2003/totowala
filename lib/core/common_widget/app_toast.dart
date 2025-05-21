import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:totowala/core/decoration/app_decoration.dart';

import '../theme/colors.dart';
import '../theme/typography.dart';

class AppToast{
  static toastMessage(BuildContext context, String msg, {Color textColor=AppColors.black,Color backgroundColor=AppColors.white, bool isLong = false}){
    return showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        decoration: AppDecoration.kCustomBoxDecorationWithShadow(12, backgroundColor, backgroundColor,AppColors.black),
        child: Text(msg,style: kTextStyleColor500( color:textColor,size: 12, isBold: false),),
      ),
      context: context,
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      animDuration: const Duration(seconds: 1),
      duration: Duration(seconds: isLong?6:3),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

}