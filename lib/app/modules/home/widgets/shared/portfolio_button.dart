import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';
import 'package:personal_portfolio/app/theme/app_shadows.dart';

class PortfolioButton extends StatefulWidget {
  const PortfolioButton({
    required this.label,
    required this.onTap,
    super.key,
    this.primary = false,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final bool primary;
  final IconData? icon;

  @override
  State<PortfolioButton> createState() => _PortfolioButtonState();
}

class _PortfolioButtonState extends State<PortfolioButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final foreground = widget.primary ? AppColors.onDark : AppColors.textPrimary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: widget.primary
                ? (_hovering
                      ? AppColors.brandDarkHover
                      : AppColors.brandDark)
                : (_hovering
                      ? AppColors.surfaceMuted
                      : AppColors.surface),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: widget.primary
                  ? Colors.transparent
                  : AppColors.borderMuted,
            ),
            boxShadow: _hovering ? AppShadows.buttonHover : const [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(widget.icon, size: 18, color: foreground),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
