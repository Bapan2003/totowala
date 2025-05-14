import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:totowala/app/navigation/app_route.dart';


class SplashScreenViewModel{


  void gotoDashboard(BuildContext context) {
    if(false){
      context.goNamed(AppRoute.dashboard);
    }else{
      context.goNamed(AppRoute.mobileNoScreen);

    }
  }

}