import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio/app/models/contact_link.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/models/portfolio_skill.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final List<PortfolioProject> projects = const [
    PortfolioProject(
      title: 'PT Ponseljobs Indonesia',
      subtitle: 'Mobile Developer',
      period: 'Production job portal',
      description:
          'Built key features for the HiredToday recruitment platform, integrated REST APIs with GetX state management, and collaborated across teams to ship scalable production-ready mobile solutions.',
      accent: Color(0xFFDDE6F0),
      icon: Icons.work_outline,
      screenshots: [
        'assets/hired_today/hiredtoday_onboarding.png',
        'assets/hired_today/hiredtoday_login.png',
        'assets/hired_today/hiredtoday_home.png',
        'assets/hired_today/hiredtoday_searchjob.png',
        'assets/hired_today/hiredtoday_jobdetail.png',
        'assets/hired_today/hiredtoday_applyjob.png',
        'assets/hired_today/hiredtoday_profile.png',
      ],
    ),
    PortfolioProject(
      title: 'PT Suitmedia Kreasi Indonesia',
      subtitle: 'Mobile Developer',
      period: 'Flutter + Firebase superapp',
      description:
          'Developed core features for the Teman Muslim production superapp, integrated REST APIs, applied GetX for efficient state handling, and collaborated using GitLab workflows.',
      accent: Color(0xFFD8E7DE),
      icon: Icons.mobile_friendly_outlined,
    ),
    PortfolioProject(
      title: 'Alterra Academy',
      subtitle: 'Flutter Developer Academy Student',
      period: 'Bloc/Cubit learning project',
      description:
          'Built RecyThing, an environmental mobile app using Flutter with Bloc/Cubit architecture, a gamified mission system, backend integrations, and GitHub-based version control.',
      accent: Color(0xFFE9E2D7),
      icon: Icons.eco_outlined,
    ),
  ];

  final List<PortfolioSkill> skills = const [
    PortfolioSkill(
      title: 'Dart / Flutter',
      description:
          '3+ years building cross-platform mobile applications with production-ready architecture and clean UI implementation.',
      icon: Icons.flutter_dash_outlined,
    ),
    PortfolioSkill(
      title: 'Firebase & REST API',
      description:
          'Integrated backend services, authentication flows, real-time features, and API-driven application data layers.',
      icon: Icons.cloud_outlined,
    ),
    PortfolioSkill(
      title: 'State Management',
      description:
          'Experienced with GetX, Bloc, and Provider to manage scalable app state and maintainable screen logic.',
      icon: Icons.account_tree_outlined,
    ),
    PortfolioSkill(
      title: 'Tooling & Collaboration',
      description:
          'Worked with Git, GitHub, GitLab, and modern team workflows to ship stable features across product teams.',
      icon: Icons.developer_board_outlined,
    ),
    PortfolioSkill(
      title: 'Additional Stack',
      description:
          'Comfortable with React Native and hybrid mobile product environments when projects require cross-team flexibility.',
      icon: Icons.integration_instructions_outlined,
    ),
  ];

  final List<ContactLink> contacts = const [
    ContactLink(
      label: 'Email',
      value: 'ferdya7414@gmail.com',
      href: 'mailto:ferdya7414@gmail.com',
    ),
    ContactLink(
      label: 'Phone',
      value: '0812-9610-5392',
      href: 'tel:081296105392',
    ),
    ContactLink(label: 'Location', value: 'Jakarta, Indonesia', href: ''),
  ];

  Future<void> scrollTo(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.08,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
