import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final LatLng? latLng;
  final String? address;

  PlaceModel({
    this.latLng,
    this.address,
  });

  // Factory constructor to create PlaceModel from a map
  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      latLng: json['latLng'] != null
          ? LatLng(
        json['latLng']['latitude'],
        json['latLng']['longitude'],
      )
          : null,
      address: json['address'],
    );
  }

  // Method to convert PlaceModel to map
  Map<String, dynamic> toJson() {
    return {
      'latLng': latLng != null
          ? {
        'latitude': latLng!.latitude,
        'longitude': latLng!.longitude,
      }
          : null,
      'address': address,
    };
  }

  // Optional: copyWith method for easy state updates
  PlaceModel copyWith({
    LatLng? latLng,
    String? address,
  }) {
    return PlaceModel(
      latLng: latLng ?? this.latLng,
      address: address ?? this.address,
    );
  }
}
