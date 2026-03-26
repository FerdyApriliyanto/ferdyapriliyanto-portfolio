import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';

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
    final isMobile = MediaQuery.sizeOf(context).width < 760;
    final radiusBase = screenshotType == ScreenshotType.landscape
        ? height
        : width;
    final screenRadius = BorderRadius.circular(radiusBase * 0.11);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radiusBase * 0.12),
        border: lightBackground
            ? null
            : Border.all(color: AppColors.borderMuted, width: 1.5),
        boxShadow: isMobile
            ? null
            : const [
                BoxShadow(
                  color: AppColors.shadowMuted,
                  blurRadius: 24,
                  offset: Offset(0, 10),
                ),
              ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: ClipRRect(
          borderRadius: screenRadius,
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            alignment: Alignment.center,
            filterQuality: FilterQuality.low,
          ),
        ),
      ),
    );
  }
}
