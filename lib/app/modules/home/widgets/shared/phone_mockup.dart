import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';

class PhoneMockup extends StatelessWidget {
  const PhoneMockup({
    required this.assetPath,
    required this.width,
    required this.height,
    this.screenshotType = ScreenshotType.portrait,
    this.lightBackground = false,
    super.key,
  });

  final String assetPath;
  final double width;
  final double height;
  final ScreenshotType screenshotType;
  final bool lightBackground;

  @override
  Widget build(BuildContext context) {
    final radiusBase = screenshotType == ScreenshotType.landscape
        ? height
        : width;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusBase * 0.12),
        border: lightBackground
            ? null
            : Border.all(color: const Color(0xFFDDD9D3), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
