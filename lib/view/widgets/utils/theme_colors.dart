import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider/theme_model.dart';

class ThemeColors {
  Color getBackgroundColor(BuildContext context) {
    return Provider.of<DarkThemeProvider>(context).darkTheme
        ? Colors.black
        : Colors.white;
  }

  Color getAppBar(BuildContext context) {
    return Provider.of<DarkThemeProvider>(context).darkTheme
        ? const Color.fromARGB(255, 40, 40, 40)
        : Colors.white;
  }

  Color getSearchBoxColor(BuildContext context) {
    return Provider.of<DarkThemeProvider>(context).darkTheme
        ? Colors.black.withOpacity(0.3)
        : Colors.grey.withOpacity(0.3);
  }

  Color getTextColor(BuildContext context) {
    return Provider.of<DarkThemeProvider>(context).darkTheme
        ? Colors.white
        : Colors.black;
  }
}
