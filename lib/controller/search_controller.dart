import 'package:weather_app/model/search_location_model.dart';

class SearchCityController {
  final SearchStartLocationModel searchStartLocationModel =
      SearchStartLocationModel();
  Future<List<String>> getSuggestions(String query) async {
    if (query.isEmpty) return [];

    SearchStartLocationFuntion().onChange(query, searchStartLocationModel);
    await Future.delayed(const Duration(seconds: 1));

    return List<String>.from(searchStartLocationModel.data.map((prediction) {
      return prediction["description"];
    }));
  }
}
