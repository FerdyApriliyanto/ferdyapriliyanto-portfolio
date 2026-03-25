import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  const AppShadows._();

  static const card = [
    BoxShadow(
      color: Color(0x10DBD4C9),
      blurRadius: 28,
      offset: Offset(0, 18),
    ),
  ];

  static const cardHover = [
    BoxShadow(
      color: Color(0x10DBD4C9),
      blurRadius: 28,
      offset: Offset(0, 18),
    ),
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 26,
      offset: Offset(0, 16),
    ),
  ];

  static const featuredCard = [
    BoxShadow(
      color: Color(0x12DAD2C7),
      blurRadius: 40,
      offset: Offset(0, 24),
    ),
  ];

  static const featuredCardHover = [
    BoxShadow(
      color: Color(0x12DAD2C7),
      blurRadius: 40,
      offset: Offset(0, 24),
    ),
    BoxShadow(
      color: Color(0x10000000),
      blurRadius: 30,
      offset: Offset(0, 18),
    ),
  ];

  static const softPanel = [
    BoxShadow(
      color: AppColors.shadowSoft,
      blurRadius: 40,
      offset: Offset(0, 20),
    ),
  ];

  static const buttonHover = [
    BoxShadow(
      color: AppColors.shadowMuted,
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
  ];
}
