import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AppHelper{


  /// To get Location
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Permission.location.serviceStatus.isEnabled;
    if (serviceEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        return await Geolocator.getCurrentPosition();
      } else {
        Map<Permission, PermissionStatus> status = await [
          Permission.location,
          Permission.accessMediaLocation,
          Permission.locationWhenInUse
        ].request();

        if (await Permission.location.isPermanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      Map<Permission, PermissionStatus> status = await [
        Permission.location,
        Permission.accessMediaLocation,
        Permission.locationWhenInUse
      ].request();

      if (await Permission.location.isPermanentlyDenied) {
        openAppSettings();
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          await Permission.locationWhenInUse.request();
          await Permission.location.request();
          await Permission.accessMediaLocation.request();
          return Future.error('Location permissions are denied');
        }
      } else {
        return await Geolocator.getCurrentPosition();
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


  static Future<BitmapDescriptor> createMarkerFromIcon(IconData iconData, Color color, {double size = 60}) async {
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    textPainter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        fontSize: size,
        fontFamily: iconData.fontFamily,
        package: iconData.fontPackage,
        color: color,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);

    final image = await pictureRecorder.endRecording().toImage(
      textPainter.width.toInt(),
      textPainter.height.toInt(),
    );
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final Uint8List bytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(bytes);
  }


  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        debugPrint(place.toString());
        String address =
            "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";

        String homeAddress="${place.street}, ${place.locality}";

        return homeAddress;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  static Future<LatLng> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final Location location = locations.first;
        return LatLng(location.latitude, location.longitude);
      } else {
        throw Exception('No location found for the given address.');
      }
    } catch (e) {
      throw Exception('Error occurred while getting coordinates: $e');
    }
  }
}