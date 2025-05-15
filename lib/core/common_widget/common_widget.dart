import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totowala/core/decoration/app_decoration.dart';
import 'package:totowala/core/theme/typography.dart';

import '../theme/colors.dart';

class CommonWidget{
  static Widget button(String title,Function() onTap,{bool isLoading=false,Color bgColor=AppColors.black,Color borderColor=AppColors.black,Color textColor=AppColors.white}){
    return GestureDetector(
      onTap: (){
        if(!isLoading){
          onTap();
        }
      },
      child: Container(
        width: double.infinity,
        decoration: AppDecoration.kCustomBoxDecoration(12, bgColor, borderColor),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(title.toUpperCase(),style: kTextStyleColor500(color: textColor,size: 16),),
      ),
    );
  }

  static Widget backButton(BuildContext context,{bool isCross=false}){
    return  GestureDetector(
      onTap: (){
        // Safely check if we can pop
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
        }
      },
      child: Container(
        height: 44,
        width: 44,
        decoration: AppDecoration.kCustomBoxDecoration(12, AppColors.transparent, AppColors.black),
        child: Icon(isCross?Icons.clear:Icons.keyboard_arrow_left_outlined,size: 35,),
      ),
    );
  }
}