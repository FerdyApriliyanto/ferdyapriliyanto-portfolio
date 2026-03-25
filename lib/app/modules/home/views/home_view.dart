import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio/app/modules/home/views/sections/contact_section.dart';
import 'package:personal_portfolio/app/modules/home/views/sections/footer_section.dart';
import 'package:personal_portfolio/app/modules/home/views/sections/hero_section.dart';
import 'package:personal_portfolio/app/modules/home/views/sections/projects_section.dart';
import 'package:personal_portfolio/app/modules/home/views/sections/skills_section.dart';
import 'package:personal_portfolio/app/modules/home/widgets/nav/mobile_menu.dart';
import 'package:personal_portfolio/app/modules/home/widgets/nav/top_navigation.dart';
import 'package:personal_portfolio/app/modules/home/widgets/shared/section_shell.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 760;
    final topInset = isMobile ? 104.0 : 120.0;

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
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      padding: EdgeInsets.only(
                        top: topInset,
                        bottom: isMobile ? 48 : 72,
                      ),
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
                              onDownloadCv: () => controller.openUrl(
                                '/Ferdy-Apriliyanto-CV.pdf',
                              ),
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
                          SectionShell(
                            sectionKey: controller.footerKey,
                            child: FooterSection(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: TopNavigation(
                      onTapHero: () => controller.scrollTo(controller.heroKey),
                      onTapProjects: () =>
                          controller.scrollTo(controller.projectsKey),
                      onTapContact: () =>
                          controller.scrollTo(controller.contactKey),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => MobileMenuOverlay(
                isOpen: controller.isMenuOpen.value,
                onClose: controller.closeMenu,
                onTapHome: () => controller.scrollTo(controller.heroKey),
                onTapExperience: () =>
                    controller.scrollTo(controller.projectsKey),
                onTapContact: () => controller.scrollTo(controller.contactKey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// AMBIENT GLOW
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
