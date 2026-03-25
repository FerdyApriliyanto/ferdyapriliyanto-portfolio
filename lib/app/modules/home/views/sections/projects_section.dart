import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/modules/home/widgets/experiences/experience_card.dart';
import 'package:personal_portfolio/app/modules/home/widgets/experiences/featured_experience_card.dart';

import '../../widgets/shared/section_title.dart';

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
            title: 'Portfolio snapshots from shipped mobile product work.',
            description:
                'A curated look at production-facing Flutter work across recruiting, Muslim lifestyle, and academy projects, with emphasis on architecture, API integration, and shipping polish.',
          ),
          const SizedBox(height: 18),
          const _ProjectsHighlights(),
          const SizedBox(height: 28),
          if (projects.isNotEmpty)
            FeaturedExperienceCard(project: projects.first),
          const SizedBox(height: 20),
          if (projects.length > 1)
            isDesktop
                ? _DesktopGrid(projects: projects, isTablet: isTablet)
                : _MobileList(projects: projects, isTablet: isTablet),
        ],
      ),
    );
  }
}

class _ProjectsHighlights extends StatelessWidget {
  const _ProjectsHighlights();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _HighlightPill(
          label: 'Role',
          value: 'Mobile Developer',
          tone: const Color(0xFFE9F1EC),
          compact: isMobile,
        ),
        _HighlightPill(
          label: 'Strength',
          value: 'API-driven features',
          tone: const Color(0xFFF3EDE3),
          compact: isMobile,
        ),
        _HighlightPill(
          label: 'Focus',
          value: 'Flutter + Product Delivery',
          tone: const Color(0xFFECEEF7),
          compact: isMobile,
          wide: true,
        ),
      ],
    );
  }
}

class _HighlightPill extends StatelessWidget {
  const _HighlightPill({
    required this.label,
    required this.value,
    required this.tone,
    required this.compact,
    this.wide = false,
  });

  final String label;
  final String value;
  final Color tone;
  final bool compact;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      constraints: BoxConstraints(
        minWidth: compact ? 120 : (wide ? 260 : 148),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 14 : 16,
        vertical: compact ? 12 : 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9E4DD)),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.9),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: tone,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              color: const Color(0xFF6A655F),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF1F1E1B),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopGrid extends StatelessWidget {
  const _DesktopGrid({required this.projects, required this.isTablet});

  final List<PortfolioProject> projects;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ExperienceCard(project: projects[1], index: 2, compact: false),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              if (projects.length > 2)
                ExperienceCard(project: projects[2], index: 3, compact: true),
              if (projects.length > 3) ...[
                const SizedBox(height: 20),
                ExperienceCard(project: projects[3], index: 4, compact: true),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileList extends StatelessWidget {
  const _MobileList({required this.projects, required this.isTablet});

  final List<PortfolioProject> projects;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 1; i < projects.length; i++) ...[
          ExperienceCard(project: projects[i], index: i + 1, compact: isTablet),
          if (i != projects.length - 1) const SizedBox(height: 20),
        ],
      ],
    );
  }
}
