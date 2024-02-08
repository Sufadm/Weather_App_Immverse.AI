import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/theme_model.dart';
import 'package:weather_app/view/widgets/utils/theme_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors().getBackgroundColor(context),
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<DarkThemeProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: provider.darkTheme,
                  onChanged: (value) {
                    provider.darkTheme = value;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
