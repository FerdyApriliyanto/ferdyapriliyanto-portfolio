import 'package:flutter/material.dart';

enum ScreenshotType { portrait, landscape }

class PortfolioProject {
  final String title;
  final String subtitle;
  final String period;
  final String description;
  final String externalLabel;
  final String externalUrl;
  final String secondaryExternalLabel;
  final String secondaryExternalUrl;
  final Color accent;
  final IconData icon;
  final List<String> screenshots;
  final ScreenshotType screenshotType;

  const PortfolioProject({
    required this.title,
    required this.subtitle,
    required this.period,
    required this.description,
    this.externalLabel = '',
    this.externalUrl = '',
    this.secondaryExternalLabel = '',
    this.secondaryExternalUrl = '',
    required this.accent,
    required this.icon,
    this.screenshots = const [],
    this.screenshotType = ScreenshotType.portrait,
  });
}
