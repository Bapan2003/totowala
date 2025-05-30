import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:totowala/app/features/auth/verify_otp/verify_otp.dart';
import 'package:totowala/app/features/checkout/checkout_screen.dart';
import 'package:totowala/app/features/search/search_screen.dart';
import 'package:totowala/app/features/search/search_view_model.dart';
import 'package:totowala/domain/repository/auth/mobile_no/mobile_no_repository.dart';
import 'package:totowala/domain/repository/splash/splash_repository.dart';


import '../../core/di/service_locator.dart';
import '../../core/utils/app_helper.dart';
import '../../domain/features/auth/mobile_no/mobile_no_bloc.dart';
import '../../domain/features/dashboard/home/home_bloc.dart';
import '../../domain/features/search/search_bloc.dart';
import '../features/dashboard/page/passenger/home/home_view_model.dart';
import '../features/screen_export.dart';
import 'app_route.dart';


enum TransitionType { fade, slide, scale, bottomToTop,}


class AppRouterConfig {


  late final GoRouter router = GoRouter(
    routes: _routes,
    initialLocation: AppRoute.root,
  );

  late final _routes = <RouteBase>[

    GoRoute(
      path: AppRoute.root,
      name: AppRoute.root,
      pageBuilder: (context,state)=>buildTransitionPage(child: SplashScreen(viewModel: SplashScreenViewModel(getIt<SplashRepository>()),), state: state,type: TransitionType.fade),
    ),

    GoRoute(
      path: AppRoute.dashboard,
      name: AppRoute.dashboard,
      pageBuilder: (context,state)=>buildTransitionPage(
          child: DashboardScreen(),
          state: state,
      ),
    ),

    GoRoute(
      path: AppRoute.mobileNoScreen,
      name: AppRoute.mobileNoScreen,
      pageBuilder: (context,state)=>buildTransitionPage(
          child: MobileNoScreen(viewModel: MobileNoViewModel(MobileInputBloc(getIt<MobileNoRepository>())),),
          state: state,
          type: TransitionType.scale
      ),
    ),

    GoRoute(
      path: AppRoute.verifyOtpScreen,  // e.g. '/verify-otp'
      name: AppRoute.verifyOtpScreen,
      pageBuilder: (context, state) {
        final mobileNo = state.uri.queryParameters['mobileNo'] ?? '';
        return buildTransitionPage(
          child: VerifyOtpScreen(mobileNo: mobileNo),
          state: state,
          type: TransitionType.scale,
        );
      },
    ),


    GoRoute(
      path: AppRoute.searchScreen,  // e.g. '/verify-otp'
      name: AppRoute.searchScreen,
      pageBuilder: (context, state) {
        return buildTransitionPage(
          child: SearchScreen(homeViewModel: HomeViewModel(HomeBloc())..fetchLocation(),searchViewModel: SearchViewModel( getIt<SearchBloc>(),),),
          state: state,
          type: TransitionType.bottomToTop,
        );
      },
    ),

    GoRoute(
      path: AppRoute.checkoutScreen,
      name: AppRoute.checkoutScreen,
      pageBuilder: (context, state) {
        final srcString = state.uri.queryParameters['src'] ?? '';
        final destString = state.uri.queryParameters['dest'] ?? '';

        final LatLng? srcLatLng = AppHelper.parseLatLng(srcString);
        final LatLng? destLatLng = AppHelper.parseLatLng(destString);
        return buildTransitionPage(
          child: CheckoutScreen(src: srcLatLng,dest: destLatLng,),
          state: state,
        );
      },
    ),

  ];

  void dispose() {}


  CustomTransitionPage buildTransitionPage({
    required Widget child,
    required GoRouterState state,
    TransitionType type = TransitionType.slide,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (type) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0), // right to left
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.bottomToTop:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1), // 👈 bottom to top
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
        }
      },
    );
  }

}