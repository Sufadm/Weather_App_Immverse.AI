import 'package:flutter/material.dart';
import 'package:weather_app/controller/search_controller.dart';
import 'package:weather_app/model/search_location_model.dart';

class CitySearchDelegate extends SearchDelegate<String> {
  final SearchStartLocationModel searchStartLocationModel =
      SearchStartLocationModel();

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: SearchCityController().getSuggestions(query),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No suggestions available'));
        } else {
          return ListView(
            children: snapshot.data!.map((suggestion) {
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  close(context, suggestion);
                },
              );
            }).toList(),
          );
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
}
