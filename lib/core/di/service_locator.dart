import 'package:get_it/get_it.dart';
import 'package:totowala/core/api/api_manager/api_manager.dart';
import 'package:totowala/core/api/api_manager/api_manager_base.dart';
import 'package:totowala/data/repository/auth/mobile_no/mobile_no_repo_imp.dart';
import 'package:totowala/data/repository/checkout/checkout_repository_imple.dart';
import 'package:totowala/data/repository/search/search_repository_imple.dart';
import 'package:totowala/data/repository/splash/splash_repository_imple.dart';
import 'package:totowala/domain/features/checkout/checkout_bloc.dart';
import 'package:totowala/domain/repository/auth/mobile_no/mobile_no_repository.dart';
import 'package:totowala/domain/repository/checkout/checkout_repository.dart';
import 'package:totowala/domain/repository/search/search_repository.dart';
import 'package:totowala/domain/repository/splash/splash_repository.dart';

import '../../domain/features/auth/mobile_no/mobile_no_bloc.dart';
import '../../domain/features/search/search_bloc.dart';



final getIt = GetIt.instance;

void setupLocator() {

  /// ✅ Core Services
  getIt.registerLazySingleton<ApiManagerBase>(()=>ApiManager());

  /// Register repository
  getIt.registerLazySingleton<SearchRepository>(() => SearchRepositoryImplement(),);
  getIt.registerLazySingleton<CheckoutRepository>(()=>CheckoutRepositoryImplement());
  getIt.registerLazySingleton<MobileNoRepository>(()=>MobileNoRepositoryImplement(getIt<ApiManagerBase>()));
  getIt.registerLazySingleton<SplashRepository>(()=>SplashRepositoryImplement(getIt<ApiManagerBase>()));


  /// Register BLoC
  getIt.registerFactory(() => SearchBloc(getIt<SearchRepository>()));
  getIt.registerFactory(()=>CheckoutBloc(getIt<CheckoutRepository>()));
  getIt.registerFactory(() => MobileInputBloc(getIt<MobileNoRepository>()));

}