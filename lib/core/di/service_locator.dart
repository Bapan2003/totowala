import 'package:get_it/get_it.dart';
import 'package:totowala/data/repository/checkout/checkout_repository_imple.dart';
import 'package:totowala/data/repository/search/search_repository_imple.dart';
import 'package:totowala/domain/features/checkout/checkout_bloc.dart';
import 'package:totowala/domain/repository/checkout/checkout_repository.dart';
import 'package:totowala/domain/repository/search/search_repository.dart';

import '../../domain/features/search/search_bloc.dart';



final getIt = GetIt.instance;

void setupLocator() {
  // Register repository
  getIt.registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImplement(),
  );

  getIt.registerLazySingleton<CheckoutRepository>(()=>CheckoutRepositoryImplement());


  // Register BLoC
  getIt.registerFactory(() => SearchBloc(getIt<SearchRepository>()));
  getIt.registerFactory(()=>CheckoutBloc(getIt<CheckoutRepository>()));
}