import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      notificationChannelId: 'driver_channel',
      initialNotificationTitle: 'Driver On Duty',
      initialNotificationContent: 'Tracking location...',
      foregroundServiceTypes: [AndroidForegroundType.location], // 👈 IMPORTANT
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: iosBackground,
    ),
  );
}

@pragma('vm:entry-point')
bool iosBackground(ServiceInstance service) {
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();


  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "Driver On Duty",
      content: "Sending live location...",
    );
  }

  Timer.periodic(Duration(seconds: 10), (timer) async {
    if (!(await Geolocator.isLocationServiceEnabled())) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    debugPrint("Sending location: ${position.latitude}, ${position.longitude}");

    // ✅ Send location to backend
    try {
      /// todo
      /// send location to api
    } catch (e) {
      debugPrint("Location post failed: $e");
    }
  });

  service.on("stopService").listen((event) {
    service.stopSelf();
  });
}
