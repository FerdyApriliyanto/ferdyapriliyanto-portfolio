import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';

class SectionToken extends StatelessWidget {
  const SectionToken({required this.label, this.dark = false, super.key});

  final String label;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: dark ? AppColors.brandDark : AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: dark ? Colors.transparent : AppColors.borderSoft,
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: dark ? AppColors.onDark : AppColors.textSecondary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
