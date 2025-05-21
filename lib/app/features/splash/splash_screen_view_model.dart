import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:totowala/app/navigation/app_route.dart';
import 'package:totowala/core/utils/app_const.dart';
import 'package:totowala/core/utils/app_settings.dart';


class SplashScreenViewModel{


  void gotoNextPage(BuildContext context) {
    bool isActive=AppSettings.getData(AppConstant.isActive)??false;
    if(isActive){
      context.goNamed(AppRoute.dashboard);
    }else{
      context.goNamed(AppRoute.mobileNoScreen);
    }
  }

}