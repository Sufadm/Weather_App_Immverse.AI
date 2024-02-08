import 'package:weather_app/controller/provider/search_location_model.dart';

class SearchCityController {
  final SearchLocationModel searchStartLocationModel = SearchLocationModel();
  Future<List<String>> getSuggestions(String query) async {
    if (query.isEmpty) return [];

    SearchLocationFuntion().onChange(query, searchStartLocationModel);
    await Future.delayed(const Duration(seconds: 1));

    return List<String>.from(searchStartLocationModel.data.map((prediction) {
      return prediction["description"];
    }));
  }
}
