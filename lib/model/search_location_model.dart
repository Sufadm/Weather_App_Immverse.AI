import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/view/widgets/utils/api_key.dart';

class SearchStartLocationModel extends ChangeNotifier {
  String _sessionToken = "";
  List<dynamic> data = [];
  String get sessionToken => _sessionToken;

  void setSessionToken(String sessionToken) {
    _sessionToken = sessionToken;
    notifyListeners();
  }

  void setData(List<dynamic> newData) {
    data = newData;
    notifyListeners();
  }
}

class SearchStartLocationFuntion {
  void onChange(String input, SearchStartLocationModel model) async {
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        "$baseUrl?input=$input&key=$googleApiKey&sessiontoken=${model.sessionToken}";
    http.Response response;
    response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      model.setData(jsonDecode(response.body)["predictions"]);
    } else {
      throw Exception("there is an error");
    }
  }
}
