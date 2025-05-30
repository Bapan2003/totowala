
// Enum for environment types
import 'dev_env.dart';

enum EnvironmentType {   dev,prod}

abstract class AppEnv{
  String get baseUrl;
  String get environmentName;


  // Singleton instance
  static late final AppEnv _instance;

  static AppEnv get instance => _instance;


  factory AppEnv.init(EnvironmentType env){
    _instance =_getEnvironment(env);
     return _instance;
  }

  static AppEnv _getEnvironment(EnvironmentType envType) {
    switch (envType) {
      case EnvironmentType.dev:
        return DevEnv();
      case EnvironmentType.prod:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

}