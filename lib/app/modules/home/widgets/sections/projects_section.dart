import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/modules/home/widgets/projects/experience_card.dart';
import 'package:personal_portfolio/app/modules/home/widgets/projects/featured_experience_card.dart';

import '../shared/section_title.dart';

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
