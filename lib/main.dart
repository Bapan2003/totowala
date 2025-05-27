import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/my_app.dart';
import 'core/di/service_locator.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initialize();
  runApp(const MyApp());
}


// Method to initialize dependency
Future<void> _initialize() async {

  setupLocator(); // Initialize dependencies

  await Hive.initFlutter(); // Step 1: Initialize Hive

  // Step 2: Open all required boxes in parallel
  await Future.wait([
    Hive.openBox('myBox'),
  ]);
}