import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/weather_service_controller.dart';
import 'package:weather_app/model/weather_ui_model.dart';

class RequestPermission {
  final BuildContext context;

  RequestPermission(this.context);

  Future<void> requestLocationPermissionAndFetchWeather() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      _getCurrentLocationAndFetchWeather();
    } else {
      print('Location permission denied');
    }
  }

  Future<void> _getCurrentLocationAndFetchWeather() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      Provider.of<WeatherService>(context, listen: false)
          .getCurrentCityWeather(position)
          .then((decodedData) {
        Provider.of<WeatherUI>(context, listen: false).updateUI(decodedData);
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }
}
