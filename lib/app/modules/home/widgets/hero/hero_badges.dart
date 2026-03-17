import 'package:flutter/material.dart';

class AvatarBadge extends StatelessWidget {
  const AvatarBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFBF8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE7E1D9), width: 1.6),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 22,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Transform.scale(
                scale: 1.28,
                alignment: const Alignment(0, -0.08),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.matrix([
                    0.55,
                    0.55,
                    0.55,
                    0,
                    -18,
                    0.55,
                    0.55,
                    0.55,
                    0,
                    -18,
                    0.55,
                    0.55,
                    0.55,
                    0,
                    -18,
                    0,
                    0,
                    0,
                    0.98,
                    0,
                  ]),
                  child: Image.asset(
                    'assets/profile/profile.jpeg',
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -0.05),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [Color(0x04FFFFFF), Color(0x34000000)],
                  ),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(color: Color(0x22000000)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoPill extends StatelessWidget {
  const InfoPill({required this.label, required this.icon, super.key});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F8F5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE8E3DB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF6C6661)),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF3A3734),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class AvailabilityPill extends StatelessWidget {
  const AvailabilityPill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE8E3DB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFF33E27A),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x5533E27A),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Open to work',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF2C2A27),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
