import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio/app/modules/home/widgets/contact_section.dart';
import 'package:personal_portfolio/app/modules/home/widgets/hero_section.dart';
import 'package:personal_portfolio/app/modules/home/widgets/projects_section.dart';
import 'package:personal_portfolio/app/modules/home/widgets/section_shell.dart';
import 'package:personal_portfolio/app/modules/home/widgets/skills_section.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 760;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFEFC), Color(0xFFF7F7F3)],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -120,
              right: -80,
              child: _AmbientGlow(color: Color(0x18D8E5DD), size: 320),
            ),
            const Positioned(
              top: 520,
              left: -100,
              child: _AmbientGlow(color: Color(0x16EEE8DE), size: 260),
            ),
            SafeArea(
              child: Column(
                children: [
                  _TopNavigation(
                    onTapHero: () => controller.scrollTo(controller.heroKey),
                    onTapProjects: () =>
                        controller.scrollTo(controller.projectsKey),
                    onTapContact: () =>
                        controller.scrollTo(controller.contactKey),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      padding: EdgeInsets.only(bottom: isMobile ? 48 : 72),
                      child: Column(
                        children: [
                          SectionShell(
                            sectionKey: controller.heroKey,
                            child: HeroSection(
                              name: 'Ferdy Apriliyanto',
                              role: 'Mobile Developer',
                              headline:
                                  'Building scalable Flutter applications with clean architecture and reliable production delivery.',
                              summary:
                                  'Mobile developer with 3+ years of experience building user-facing Flutter apps, integrating REST APIs and Firebase services, and shipping polished mobile experiences for real products.',
                              onViewWork: () =>
                                  controller.scrollTo(controller.projectsKey),
                              onContact: () =>
                                  controller.scrollTo(controller.contactKey),
                            ),
                          ),
                          SectionShell(
                            sectionKey: controller.projectsKey,
                            child: ProjectsSection(
                              projects: controller.projects,
                            ),
                          ),
                          SectionShell(
                            sectionKey: controller.skillsKey,
                            child: SkillsSection(skills: controller.skills),
                          ),
                          SectionShell(
                            sectionKey: controller.contactKey,
                            child: ContactSection(
                              contacts: controller.contacts,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Navigation Bar ────────────────────────────────────────────────────────────

class _TopNavigation extends StatefulWidget {
  const _TopNavigation({
    required this.onTapHero,
    required this.onTapProjects,
    required this.onTapContact,
  });

  final VoidCallback onTapHero;
  final VoidCallback onTapProjects;
  final VoidCallback onTapContact;

  @override
  State<_TopNavigation> createState() => _TopNavigationState();
}

class _TopNavigationState extends State<_TopNavigation> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 920;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 36,
        24,
        isMobile ? 20 : 36,
        8,
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              'FA',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const Spacer(),
          if (!isMobile) ...[
            _NavButton(
              key: const ValueKey('nav_home'),
              label: 'Home',
              onTap: widget.onTapHero,
            ),
            _NavButton(
              key: const ValueKey('nav_experience'),
              label: 'Experience',
              onTap: widget.onTapProjects,
            ),
            _NavButton(
              key: const ValueKey('nav_contact'),
              label: 'Contact',
              onTap: widget.onTapContact,
            ),
            const SizedBox(width: 16),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFEAE7E1)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Text(
              isMobile ? 'Portfolio' : 'Jakarta, Indonesia',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF5D5C57),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Nav Button ────────────────────────────────────────────────────────────────

class _NavButton extends StatefulWidget {
  const _NavButton({required this.label, required this.onTap, super.key});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: _hovering
                  ? const Color(0xFFAAAAAA)
                  : const Color(0xFF353535),
              fontWeight: FontWeight.w600,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

// ── Ambient Glow ──────────────────────────────────────────────────────────────

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: color, blurRadius: 120, spreadRadius: 40),
          ],
        ),
      ),
    );
  }
}
