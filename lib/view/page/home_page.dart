import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/permission_controller.dart';
import 'package:weather_app/controller/weather_service_controller.dart';
import 'package:weather_app/model/weather_ui_model.dart';
import 'package:weather_app/view/widgets/utils/theme_colors.dart';
import 'package:weather_app/view/page/search_page.dart';
import 'package:weather_app/view/page/settings_page.dart';
import 'package:weather_app/view/widgets/container_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    RequestPermission(context).requestLocationPermissionAndFetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SettingsPage();
                }));
              },
            ),
          )
        ],
        backgroundColor: ThemeColors().getAppBar(context),
      ),
      backgroundColor: ThemeColors().getBackgroundColor(context),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextFormField(
                readOnly: true,
                onTap: () async {
                  FocusScopeNode currentfocus = FocusScope.of(context);
                  if (!currentfocus.hasPrimaryFocus) {
                    currentfocus.unfocus();
                  }
                  final city = await showSearch<String>(
                    context: context,
                    delegate: CitySearchDelegate(),
                  );

                  if (city != null) {
                    Provider.of<WeatherService>(context, listen: false)
                        .getCityWeather(city)
                        .then((decodedData) {
                      Provider.of<WeatherUI>(context, listen: false)
                          .updateUI(decodedData);
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: "Enter your location",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.pin_drop,
                    color: Colors.red,
                    size: 40,
                  ),
                  Consumer<WeatherUI>(
                    builder: (context, weatherUI, _) {
                      return Text(
                        weatherUI.cityname,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ContainerBox(
              cover: Provider.of<WeatherUI>(context).cover,
              imageUrl:
                  'assets/thermocare-room-temperature-for-wall-mounting-yellow-thermometer-original-imafpe532fhgqq2y-removebg-preview.png',
              text:
                  'Temperature: ${Provider.of<WeatherUI>(context).temp?.toInt() ?? 'N/A'} ºC',
            ),
            ContainerBox(
              cover: Provider.of<WeatherUI>(context).cover,
              imageUrl:
                  'assets/Meg-pressure-gauge-drawing-image-removebg-preview.png',
              text:
                  'Pressure: ${Provider.of<WeatherUI>(context).press?.toInt() ?? 'N/A'} hPa',
            ),
            ContainerBox(
              cover: Provider.of<WeatherUI>(context).cover,
              imageUrl: 'assets/3262966.png',
              text:
                  'Humidity: ${Provider.of<WeatherUI>(context).hum?.toInt() ?? 'N/A'} %',
            ),
            ContainerBox(
              cover: Provider.of<WeatherUI>(context).cover,
              imageUrl: 'assets/7be218a3cf1708c6c5f628daf83a4718.jpg',
              text:
                  'CloudCover: ${Provider.of<WeatherUI>(context).cover?.toInt() ?? 'N/A'} %',
            ),
          ],
        ),
      ),
    );
  }
}
