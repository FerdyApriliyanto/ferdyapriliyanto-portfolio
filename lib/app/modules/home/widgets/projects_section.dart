import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/modules/home/controllers/home_controller.dart';

import 'section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({required this.projects, super.key});

  final List<PortfolioProject> projects;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1040;
    final isTablet = width >= 760;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            eyebrow: 'Selected Experience',
            title: 'Recent roles and production work across mobile teams.',
            description:
                'A short overview of hands-on Flutter experience across recruitment, superapp, and academy environments, with focus on architecture, API integration, and collaboration.',
          ),
          const SizedBox(height: 28),
          if (projects.isNotEmpty)
            _FeaturedExperienceCard(project: projects.first),
          const SizedBox(height: 20),
          if (projects.length > 1)
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _ExperienceCard(
                          project: projects[1],
                          index: 2,
                          compact: false,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            if (projects.length > 2)
                              _ExperienceCard(
                                project: projects[2],
                                index: 3,
                                compact: true,
                              ),
                            if (projects.length > 3) ...[
                              const SizedBox(height: 20),
                              _ExperienceCard(
                                project: projects[3],
                                index: 4,
                                compact: true,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      for (var i = 1; i < projects.length; i++) ...[
                        _ExperienceCard(
                          project: projects[i],
                          index: i + 1,
                          compact: isTablet,
                        ),
                        if (i != projects.length - 1)
                          const SizedBox(height: 20),
                      ],
                    ],
                  ),
        ],
      ),
    );
  }
}

class _FeaturedExperienceCard extends StatefulWidget {
  const _FeaturedExperienceCard({required this.project});

  final PortfolioProject project;

  @override
  State<_FeaturedExperienceCard> createState() =>
      _FeaturedExperienceCardState();
}

class _FeaturedExperienceCardState extends State<_FeaturedExperienceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 760;
    final textTheme = Theme.of(context).textTheme;
    final project = widget.project;

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
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile ? 0 : 5,
              child: Container(
                constraints: BoxConstraints(minHeight: isMobile ? 220 : 320),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [project.accent, Colors.white],
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: _SectionToken(label: '01', dark: true),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          project.period,
                          style: textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF3A3834),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: isMobile ? 150 : 190,
                        height: isMobile ? 150 : 190,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(38),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 24,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          project.icon,
                          size: isMobile ? 52 : 68,
                          color: const Color(0xFF2B2B2B),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: const Color(0x22FFFFFF),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0x33FFFFFF)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: isMobile ? 0 : 22, height: isMobile ? 18 : 0),
            Expanded(
              flex: isMobile ? 0 : 6,
              child: Padding(
                padding: EdgeInsets.only(top: isMobile ? 6 : 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF191919),
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _SectionToken(label: project.subtitle),
                        _SectionToken(label: 'Production Work'),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      project.description,
                      style: textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF66625E),
                        height: 1.75,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(18),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard({
    required this.project,
    required this.index,
    required this.compact,
  });

  final PortfolioProject project;
  final int index;
  final bool compact;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final project = widget.project;

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
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFEEEAE3)),
          boxShadow: _hovering
              ? const [
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
                      _SectionToken(label: '0${widget.index}'),
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
          ],
        ),
      ),
    );
  }
}

class _SectionToken extends StatelessWidget {
  const _SectionToken({required this.label, this.dark = false});

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
