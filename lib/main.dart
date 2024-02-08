import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/search_location_model.dart';
import 'package:weather_app/model/theme_model.dart';
import 'package:weather_app/controller/weather_service_controller.dart';
import 'package:weather_app/model/weather_ui_model.dart';
import 'package:weather_app/view/page/home_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        Provider<WeatherService>(create: (_) => WeatherService()),
        ChangeNotifierProvider<WeatherUI>(create: (_) => WeatherUI()),
        ChangeNotifierProvider(
          create: (context) => DarkThemeProvider(true),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchStartLocationModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ImmersiveAI Task',
          theme: provider.darkTheme ? ThemeData.dark() : ThemeData.light(),
          home: const HomePage(),
        );
      },
    );
  }
}
