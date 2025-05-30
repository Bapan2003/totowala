import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/my_app.dart';
import 'core/api/app_env/app_env.dart';
import 'core/di/service_locator.dart';
import 'core/services/background_services.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initialize();
  runApp(const MyApp());
}


// Method to initialize dependency
Future<void> _initialize() async {

  await initializeService(); // Initialize background service

  /// Get environment from --dart-define
  /// cmd for production bundle->  flutter build appbundle --release --dart-define=ENV=prod
  ///  cmd for production release->  flutter build apk --release --dart-define=ENV=prod
  ///  cmd for development release->  flutter build apk --release --dart-define=ENV=dev
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');


  /// Initialize the environment once
  AppEnv.init(env == 'dev' ? EnvironmentType.dev : EnvironmentType.prod);

  setupLocator(); // Initialize dependencies

  await Hive.initFlutter(); // Step 1: Initialize Hive

  // Step 2: Open all required boxes in parallel
  await Future.wait([
    Hive.openBox('myBox'),
  ]);
}

