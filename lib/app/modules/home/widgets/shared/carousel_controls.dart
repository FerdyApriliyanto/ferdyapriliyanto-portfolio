import 'package:flutter/material.dart';

class CarouselButton extends StatelessWidget {
  const CarouselButton({
    required this.icon,
    required this.onTap,
    this.tinted = false,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: onTap != null ? 1.0 : 0.28,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: tinted
                ? Colors.white.withValues(alpha: 0.7)
                : const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: tinted
                  ? Colors.white.withValues(alpha: 0.5)
                  : const Color(0xFFE2DDD7),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: const Color(0xFF2D2D2D)),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({required this.active, this.tinted = false, super.key});

  final bool active;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: active ? 18 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active
            ? (tinted ? Colors.white : const Color(0xFF2D2D2D))
            : (tinted
                  ? Colors.white.withValues(alpha: 0.4)
                  : const Color(0xFFD5D0CA)),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
