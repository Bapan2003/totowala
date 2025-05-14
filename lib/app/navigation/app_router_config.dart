import 'package:go_router/go_router.dart';
import 'package:totowala/domain/auth/mobile_no/mobile_no_bloc.dart';

import '../features/screen_export.dart';
import 'app_route.dart';

class AppRouterConfig {


  late final GoRouter router = GoRouter(
    routes: _routes,
    initialLocation: AppRoute.root,
  );

  late final _routes = <RouteBase>[

    GoRoute(
      path: AppRoute.root,
      name: AppRoute.root,
      builder: (context, state) => SplashScreen(
        viewModel: SplashScreenViewModel(),
      ),
    ),

    GoRoute(
      path: AppRoute.dashboard,
      name: AppRoute.dashboard,
      builder: (context, state) => DashboardScreen(),
    ),

    GoRoute(
      path: AppRoute.mobileNoScreen,
      name: AppRoute.mobileNoScreen,
      builder: (context, state) => MobileNoScreen(viewModel: MobileNoViewModel(MobileInputBloc()),),
    ),

  ];

  void dispose() {}
}