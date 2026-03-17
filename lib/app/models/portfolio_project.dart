import 'package:flutter/material.dart';

class PortfolioProject {
  const PortfolioProject({
    required this.title,
    required this.subtitle,
    required this.period,
    required this.description,
    required this.accent,
    required this.icon,
    this.screenshots = const [],
  });

  final String title;
  final String subtitle;
  final String period;
  final String description;
  final Color accent;
  final IconData icon;
  final List<String> screenshots;
}
