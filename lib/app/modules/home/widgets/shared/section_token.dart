import 'package:flutter/material.dart';

class SectionToken extends StatelessWidget {
  const SectionToken({required this.label, this.dark = false, super.key});

  final String label;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF191919) : const Color(0xFFF8F8F5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: dark ? Colors.transparent : const Color(0xFFECE8E2),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: dark ? Colors.white : const Color(0xFF5D5955),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
