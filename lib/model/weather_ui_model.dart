import 'package:flutter/material.dart';

class WeatherUI extends ChangeNotifier {
  num? temp;
  num? press;
  num? hum;
  num? cover;
  String cityname = '';

  void updateUI(var decodedData) {
    if (decodedData == null) {
      temp = 0;
      press = 0;
      hum = 0;
      cover = 0;
      cityname = 'Not available';
    } else {
      temp = decodedData['main']['temp'] - 273;
      press = decodedData['main']['pressure'];
      hum = decodedData['main']['humidity'];
      cover = decodedData['clouds']['all'];
      cityname = decodedData['name'];
    }
    notifyListeners();
  }
}
