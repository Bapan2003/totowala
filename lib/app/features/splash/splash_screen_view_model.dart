import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:totowala/app/navigation/app_route.dart';
import 'package:totowala/core/utils/app_const.dart';
import 'package:totowala/core/utils/app_settings.dart';
import 'package:totowala/domain/repository/splash/splash_repository.dart';


class SplashScreenViewModel{
  final SplashRepository _splashRepository;
  SplashScreenViewModel(this._splashRepository);



  Future<void> refreshToken(BuildContext context)async{
    try{
      /// todo uncomment, for now off
      // final String accessToken= await _splashRepository.refreshToken()??'';
      // AppSettings.saveAccessToken(accessToken);
      context.goNamed(AppRoute.dashboard);
    }catch(e){
      AppSettings.clearAll();
      context.goNamed(AppRoute.mobileNoScreen);
    }
  }

  void gotoNextPage(BuildContext context) {
    bool isActive=AppSettings.getData(AppConstant.isActive)??false;
    if(isActive){
      refreshToken(context);
    }else{
      context.goNamed(AppRoute.mobileNoScreen);
    }
  }

}