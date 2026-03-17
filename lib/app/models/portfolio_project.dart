import 'package:flutter/material.dart';

enum ScreenshotType { portrait, landscape }

class PortfolioProject {
  final String title;
  final String subtitle;
  final String period;
  final String description;
  final Color accent;
  final IconData icon;
  final List<String> screenshots;
  final ScreenshotType screenshotType;

  const PortfolioProject({
    required this.title,
    required this.subtitle,
    required this.period,
    required this.description,
    required this.accent,
    required this.icon,
    this.screenshots = const [],
    this.screenshotType = ScreenshotType.portrait,
  });
}
