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
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: tinted
                ? Colors.white.withValues(alpha: 0.7)
                : const Color(0xFFE8E3DC),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: tinted
                  ? Colors.white.withValues(alpha: 0.5)
                  : const Color(0xFFB5AFA7),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
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
      width: active ? 16 : 6,
      height: 4,
      decoration: BoxDecoration(
        color: active
            ? (tinted
                  ? Color(0xFF1E1E1E).withValues(alpha: 0.90)
                  : const Color(0xFF2D2D2D))
            : (tinted
                  ? Color(0xFF1E1E1E).withValues(alpha: 0.24)
                  : const Color(0xFF7D7870)),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
