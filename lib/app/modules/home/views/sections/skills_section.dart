import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/portfolio_skill.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';
import 'package:personal_portfolio/app/theme/app_shadows.dart';

import '../../widgets/shared/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({required this.skills, super.key});

  final List<PortfolioSkill> skills;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            eyebrow: 'Skills',
            title: 'Core technologies used in daily Flutter development.',
            description:
                'A selection of technologies I use to build, integrate, and deliver scalable mobile applications.',
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: skills
                .map((skill) => _SkillCard(skill: skill, isMobile: isMobile))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  const _SkillCard({required this.skill, required this.isMobile});

  final PortfolioSkill skill;
  final bool isMobile;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: SizedBox(
        width: widget.isMobile ? double.infinity : 360,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.border),
            boxShadow: _hovering
                ? AppShadows.buttonHover
                : const [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(widget.skill.icon, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 18),
              Text(
                widget.skill.title,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.skill.description,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMuted,
                  height: 1.65,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
