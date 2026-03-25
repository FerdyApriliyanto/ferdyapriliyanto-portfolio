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
    final isTablet = MediaQuery.sizeOf(context).width < 1040;
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
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFFFFF), Color(0xFFFFFCF6)],
          ),
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: const Color(0xFFEEEAE3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12DAD2C7),
              blurRadius: 40,
              offset: Offset(0, 24),
            ),
          ],
        ).copyWith(
          boxShadow: _hovering
              ? const [
                  BoxShadow(
                    color: Color(0x12DAD2C7),
                    blurRadius: 40,
                    offset: Offset(0, 24),
                  ),
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
                compactInfo: isTablet,
              ),
      ),
    );
  }
}

class _FeaturedCardDesktop extends StatelessWidget {
  const _FeaturedCardDesktop({
    required this.project,
    required this.hasScreenshots,
    required this.compactInfo,
  });

  final PortfolioProject project;
  final bool hasScreenshots;
  final bool compactInfo;

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
        Expanded(
          child: _FeaturedCardInfo(
            project: project,
            featured: true,
            compact: compactInfo,
          ),
        ),
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
        _FeaturedCardInfo(project: project, featured: true),
        if (project.screenshots.isNotEmpty) ...[
          const SizedBox(height: 24),
          ScreenshotStrip(project: project),
        ],
      ],
    );
  }
}

class _FeaturedCardInfo extends StatelessWidget {
  const _FeaturedCardInfo({
    required this.project,
    this.featured = false,
    this.compact = false,
  });

  final PortfolioProject project;
  final bool featured;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenshotLabel = project.screenshotType == ScreenshotType.landscape
        ? 'Landscape showcase'
        : 'Mobile flows';

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SectionToken(label: '01', dark: true),
              if (featured) ...[
                const SizedBox(width: 10),
                _MicroBadge(
                  icon: Icons.workspace_premium_outlined,
                  label: 'Featured Build',
                ),
              ],
            ],
          ),
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
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _InfoChip(
                label: project.period,
                icon: Icons.schedule_outlined,
              ),
              _InfoChip(
                label: screenshotLabel,
                icon: Icons.photo_library_outlined,
              ),
            ],
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
            padding: EdgeInsets.all(compact ? 14 : 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F8F5),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEFEBE4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Snapshot',
                        style: textTheme.titleSmall?.copyWith(
                          color: const Color(0xFF2A2824),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Focused on scalable delivery, API-connected flows, and production-ready mobile feature rollout.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF5F5A55),
                          height: 1.65,
                        ),
                      ),
                    ],
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F8F5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFECE8E2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF4D4944)),
          const SizedBox(width: 8),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: const Color(0xFF3A3834),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MicroBadge extends StatelessWidget {
  const _MicroBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E1B),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 7),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
