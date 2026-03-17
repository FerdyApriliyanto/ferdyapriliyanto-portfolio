import 'package:flutter/material.dart';

class HeroProfilePanel extends StatelessWidget {
  const HeroProfilePanel({required this.summary, super.key});

  final String summary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F8F5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFECE7DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: textTheme.labelLarge?.copyWith(
              color: const Color(0xFF7A746F),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            summary,
            style: textTheme.titleLarge?.copyWith(
              fontSize: 24,
              height: 1.38,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1D1D1D),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 22),
          const _MetricRow(label: 'Experience', value: '3+ years'),
          const SizedBox(height: 14),
          const _MetricRow(label: 'Core stack', value: 'Flutter, GetX, Bloc'),
          const SizedBox(height: 14),
          const _MetricRow(label: 'Focus', value: 'Production mobile apps'),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF7A746F),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF1C1C1C),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
