import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  const AppGradients._();

  static const pageBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.pageGradientTop, AppColors.pageGradientBottom],
  );

  static const heroSurface = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.surface, Color(0xFFFFFCF6)],
  );

  static const cardSurface = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.surface, Color(0xFFFFFCF8)],
  );

  static const brandDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.brandDark, Color(0xFF33312E)],
  );

  static const mobileMenuButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.brandDark, Color(0xFF312F2C)],
  );

  static const mobileMenuSurface = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xEFFFFFFF), Color(0xE8FFFCF7)],
  );

  static const mobileMenuButtonSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.pageGradientTop, Color(0xFFF1E8DA)],
  );

  static const avatarOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.whiteOverlay04, AppColors.blackOverlay34],
  );

  static const storeGooglePlay = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.pageGradientTop, Color(0xFFF5F1EB)],
  );

  static const storeGooglePlayHover = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.surface, Color(0xFFF1EEE8)],
  );

  static const storeAppStore = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF242424), Color(0xFF3A3A3A)],
  );

  static const storeAppStoreHover = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.textPrimary, Color(0xFF343434)],
  );
}
