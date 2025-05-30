import 'package:totowala/core/api/app_env/app_env.dart';

class DevEnv implements AppEnv{
  @override
  // TODO: implement baseUrl
  String get baseUrl => "https://rapido-project-spring-boot.onrender.com/v1/api";

  @override
  // TODO: implement environmentName
  String get environmentName => "Development";

}