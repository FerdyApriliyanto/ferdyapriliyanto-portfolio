import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/modules/home/widgets/experiences/screenshot_strip.dart';
import 'package:personal_portfolio/app/modules/home/widgets/shared/section_token.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';
import 'package:personal_portfolio/app/theme/app_gradients.dart';
import 'package:personal_portfolio/app/theme/app_shadows.dart';

class ExperienceCard extends StatefulWidget {
  const ExperienceCard({
    required this.project,
    required this.index,
    required this.compact,
    super.key,
  });

  final PortfolioProject project;
  final int index;
  final bool compact;

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMobile = MediaQuery.sizeOf(context).width < 760;
    final project = widget.project;
    final screenshotLabel = project.screenshotType == ScreenshotType.landscape
        ? 'Landscape deck'
        : 'App screens';
    final cardDecoration = BoxDecoration(
      gradient: AppGradients.cardSurface,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: AppColors.border),
      boxShadow: isMobile ? null : AppShadows.card,
    ).copyWith(boxShadow: !isMobile && _hovering ? AppShadows.cardHover : null);

    final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionToken(label: '0${widget.index}'),
                      const SizedBox(height: 16),
                      Text(
                        project.title,
                        style: textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.subtitle,
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _MiniMeta(label: screenshotLabel),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Transform.rotate(
                  angle: widget.compact ? -0.05 : 0.05,
                  child: Container(
                    width: widget.compact ? 72 : 86,
                    height: widget.compact ? 72 : 86,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [project.accent, Colors.white],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      project.icon,
                      color: AppColors.textPrimary,
                      size: widget.compact ? 30 : 34,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFF0ECE6)),
              ),
              child: Text(
                project.description,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMuted,
                  height: 1.7,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.borderMuted),
                ),
                child: Text(
                  project.period,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (project.screenshots.isNotEmpty) ...[
              const SizedBox(height: 16),
              ScreenshotStrip(project: project),
            ],
          ],
        );

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: cardDecoration,
        child: content,
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0, _hovering ? -5 : 0, 0, 1),
        padding: const EdgeInsets.all(20),
        decoration: cardDecoration,
        child: content,
      ),
    );
  }
}

class _MiniMeta extends StatelessWidget {
  const _MiniMeta({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F4EE),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE8E1D7)),
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
