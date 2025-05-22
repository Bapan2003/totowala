import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totowala/app/navigation/app_router_config.dart';
import 'package:totowala/domain/features/dashboard/dashboard/dashboard_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _appRouterConfig = AppRouterConfig();

  @override
  void dispose() {
    _appRouterConfig.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouterConfig.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
