import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/modules/home/widgets/projects/screenshot_strip.dart';
import 'package:personal_portfolio/app/modules/home/widgets/shared/section_token.dart';

class FeaturedExperienceCard extends StatefulWidget {
  const FeaturedExperienceCard({required this.project, super.key});

  final PortfolioProject project;

  @override
  State<FeaturedExperienceCard> createState() => _FeaturedExperienceCardState();
}

class _FeaturedExperienceCardState extends State<FeaturedExperienceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;
    final project = widget.project;
    final hasScreenshots = project.screenshots.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0, _hovering ? -6 : 0, 0, 1),
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: const Color(0xFFEEEAE3)),
          boxShadow: _hovering
              ? const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 30,
                    offset: Offset(0, 18),
                  ),
                ]
              : const [],
        ),
        child: isMobile
            ? _FeaturedCardMobile(project: project)
            : _FeaturedCardDesktop(
                project: project,
                hasScreenshots: hasScreenshots,
              ),
      ),
    );
  }
}

class _FeaturedCardDesktop extends StatelessWidget {
  const _FeaturedCardDesktop({
    required this.project,
    required this.hasScreenshots,
  });

  final PortfolioProject project;
  final bool hasScreenshots;

  @override
  Widget build(BuildContext context) {
    if (!hasScreenshots) {
      return _FeaturedCardInfo(project: project);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(child: ScreenshotStrip(project: project)),
        ),
        const SizedBox(width: 28),
        Expanded(child: _FeaturedCardInfo(project: project)),
      ],
    );
  }
}

class _FeaturedCardMobile extends StatelessWidget {
  const _FeaturedCardMobile({required this.project});

  final PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FeaturedCardInfo(project: project),
        if (project.screenshots.isNotEmpty) ...[
          const SizedBox(height: 24),
          ScreenshotStrip(project: project),
        ],
      ],
    );
  }
}

class _FeaturedCardInfo extends StatelessWidget {
  const _FeaturedCardInfo({required this.project});

  final PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionToken(label: '01', dark: true),
          const SizedBox(height: 20),
          Text(
            project.title,
            style: textTheme.headlineSmall?.copyWith(
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
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F8F5),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFECE8E2)),
            ),
            child: Text(
              project.period,
              style: textTheme.bodySmall?.copyWith(
                color: const Color(0xFF3A3834),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            project.description,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF5F5A55),
              height: 1.75,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F8F5),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEFEBE4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.auto_awesome_outlined,
                    size: 18,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Focused on scalable delivery, API-connected flows, and production-ready mobile feature rollout.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF5F5A55),
                      height: 1.65,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
