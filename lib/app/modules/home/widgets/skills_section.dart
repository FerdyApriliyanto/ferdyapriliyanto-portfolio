import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/modules/home/controllers/home_controller.dart';

import 'section_title.dart';

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
                'Technical strengths from your CV, covering implementation, integrations, state management, and team workflow tooling.',
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: widget.isMobile ? double.infinity : 360,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFEEEAE3)),
          boxShadow: _hovering
              ? const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ]
              : const [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(widget.skill.icon, color: const Color(0xFF2D2D2D)),
            ),
            const SizedBox(height: 18),
            Text(
              widget.skill.title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F1F1F),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.skill.description,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF67635F),
                height: 1.65,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
