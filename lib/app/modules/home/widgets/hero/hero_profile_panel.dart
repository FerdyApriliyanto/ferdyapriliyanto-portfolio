import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';

class HeroProfilePanel extends StatelessWidget {
  const HeroProfilePanel({required this.summary, super.key});

  final String summary;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 18 : 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            summary,
            style: (isMobile ? textTheme.titleMedium : textTheme.titleLarge)
                ?.copyWith(
              fontSize: isMobile ? 18 : 24,
              height: isMobile ? 1.45 : 1.38,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              letterSpacing: isMobile ? -0.25 : -0.5,
            ),
          ),
          SizedBox(height: isMobile ? 18 : 22),
          _MetricRow(label: 'Experience', value: '3+ years', compact: isMobile),
          SizedBox(height: isMobile ? 12 : 14),
          _MetricRow(
            label: 'Core stack',
            value: 'Flutter, GetX, Firebase',
            compact: isMobile,
          ),
          SizedBox(height: isMobile ? 12 : 14),
          _MetricRow(
            label: 'Focus',
            value: 'Production mobile apps',
            compact: isMobile,
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.label,
    required this.value,
    required this.compact,
  });

  final String label;
  final String value;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (compact) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
