import 'package:flutter_dotenv/flutter_dotenv.dart';

const String domain = "https://api.openweathermap.org/data/2.5/weather?";
String? apiKey = dotenv.env['APIURL'];
String? googleApiKey = dotenv.env['GOOGLEAPI'];
