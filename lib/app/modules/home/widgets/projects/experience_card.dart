import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/modules/home/widgets/projects/screenshot_strip.dart';
import 'package:personal_portfolio/app/modules/home/widgets/shared/section_token.dart';

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
    final project = widget.project;
    final screenshotLabel = project.screenshotType == ScreenshotType.landscape
        ? 'Landscape deck'
        : 'App screens';

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0, _hovering ? -5 : 0, 0, 1),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFFFFF), Color(0xFFFFFCF8)],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFEEEAE3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10DBD4C9),
              blurRadius: 28,
              offset: Offset(0, 18),
            ),
          ],
        ).copyWith(
          boxShadow: _hovering
              ? const [
                  BoxShadow(
                    color: Color(0x10DBD4C9),
                    blurRadius: 28,
                    offset: Offset(0, 18),
                  ),
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 26,
                    offset: Offset(0, 16),
                  ),
                ]
              : const [],
        ),
        child: Column(
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
                          color: const Color(0xFF1D1D1D),
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.subtitle,
                        style: textTheme.titleSmall?.copyWith(
                          color: const Color(0xFF5D5954),
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
                      color: const Color(0xFF2D2D2D),
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
                color: const Color(0xFFF9F8F5),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFF0ECE6)),
              ),
              child: Text(
                project.description,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF66625E),
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
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFFEAE7E1)),
                ),
                child: Text(
                  project.period,
                  style: textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF57534E),
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
        ),
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
          color: const Color(0xFF66615C),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
