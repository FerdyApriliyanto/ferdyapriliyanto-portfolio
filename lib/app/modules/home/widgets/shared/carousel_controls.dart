import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';

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
                ? AppColors.surface.withValues(alpha: 0.7)
                : AppColors.borderWarm,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: tinted
                  ? AppColors.surface.withValues(alpha: 0.5)
                  : AppColors.textMuted.withValues(alpha: 0.45),
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowSoft,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: AppColors.textPrimary),
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
                  ? AppColors.textPrimary.withValues(alpha: 0.90)
                  : AppColors.textPrimary)
            : (tinted
                  ? AppColors.textPrimary.withValues(alpha: 0.24)
                  : AppColors.textMuted.withValues(alpha: 0.78)),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
