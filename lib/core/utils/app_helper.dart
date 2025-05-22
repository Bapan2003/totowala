import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_const.dart';
import 'app_settings.dart';

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

        return address;
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

  static String cropTitleFromWhole(String whole, String title) {
    if (whole.startsWith(title)) {
      String cropped = whole.substring(title.length);

      // Remove leading punctuation and spaces (commas, dashes, colons, etc.)
      cropped = cropped.replaceFirst(RegExp(r'^[\s,;:.\-]+'), '');

      return cropped.trim();
    }
    return whole.trim();
  }

  static List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return points;
  }

  static LatLng? parseLatLng(String str) {
    final parts = str.split(',');
    if (parts.length == 2) {
      final lat = double.tryParse(parts[0]);
      final lng = double.tryParse(parts[1]);
      if (lat != null && lng != null) {
        return LatLng(lat, lng);
      }
    }
    return null;
  }

  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double x0 = list[0].latitude, x1 = list[0].latitude;
    double y0 = list[0].longitude, y1 = list[0].longitude;
    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  static  bool checkDriverOrNot() {
    return  AppSettings.getData(AppConstant.isDriver)??false;
  }
}