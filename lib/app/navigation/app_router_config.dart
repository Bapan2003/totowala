import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:totowala/app/features/auth/verify_otp/verify_otp.dart';
import 'package:totowala/domain/auth/mobile_no/mobile_no_bloc.dart';

import '../features/screen_export.dart';
import 'app_route.dart';


enum TransitionType { fade, slide, scale }


class AppRouterConfig {


  late final GoRouter router = GoRouter(
    routes: _routes,
    initialLocation: AppRoute.root,
  );

  late final _routes = <RouteBase>[

    GoRoute(
      path: AppRoute.root,
      name: AppRoute.root,
      pageBuilder: (context,state)=>buildTransitionPage(child: SplashScreen(viewModel: SplashScreenViewModel(),), state: state,type: TransitionType.fade),
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
          child: MobileNoScreen(viewModel: MobileNoViewModel(MobileInputBloc()),),
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
        }
      },
    );
  }

}