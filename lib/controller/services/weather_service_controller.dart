import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/view/widgets/utils/api_key.dart' as k;

class WeatherService {
  Future<Map<String, dynamic>> getCityWeather(String cityName) async {
    try {
      var client = http.Client();
      var uri = '${k.domain}q=$cityName&appid=${k.apiKey}';
      var url = Uri.parse(uri);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var data = response.body;
        return json.decode(data);
      } else {
        return {};
      }
    } catch (e) {
      return {'error': 'Failed to fetch current city weather data'};
    }
  }

  Future<Map<String, dynamic>> getCurrentCityWeather(Position position) async {
    try {
      var client = http.Client();
      var uri =
          '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = response.body;
        return json.decode(data);
      } else {
        return {};
      }
    } catch (e) {
      return {
        'error': 'An error occurred while fetching current city weather data'
      };
    }
  }
}
