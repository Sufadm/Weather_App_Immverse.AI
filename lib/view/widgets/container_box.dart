import 'package:flutter/material.dart';
import 'package:weather_app/view/widgets/utils/theme_colors.dart';

class ContainerBox extends StatelessWidget {
  const ContainerBox({
    super.key,
    required this.cover,
    required this.imageUrl,
    required this.text,
  });

  final num? cover;
  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.12,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColors().getTextColor(context)),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: ThemeColors().getBackgroundColor(context),
        boxShadow: const [],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Image(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.09,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ThemeColors().getTextColor(context)),
          )
        ],
      ),
    );
  }
}
