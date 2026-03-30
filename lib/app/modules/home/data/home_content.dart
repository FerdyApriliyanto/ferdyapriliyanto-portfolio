import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/contact_link.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/models/portfolio_skill.dart';

class HomeContent {
  const HomeContent._();

  static const List<PortfolioProject> projects = [
    PortfolioProject(
      title: 'Teman Muslim',
      subtitle: 'PT Suitmedia Kreasi Indonesia | Mobile Developer',
      period: 'Flutter + Firebase superapp',
      description:
          'Developed core features for the Teman Muslim production superapp, integrated REST APIs, applied GetX for efficient state handling, and collaborated using GitLab workflows.',
      externalLabel: 'View on Google Play',
      externalUrl:
          'https://play.google.com/store/apps/details?id=com.temanmuslim&pcampaignid=web_share',
      secondaryExternalLabel: 'View on App Store',
      secondaryExternalUrl:
          'https://apps.apple.com/us/app/teman-muslim-al-quran-sholat/id6739802776',
      accent: Color(0xFFD8E7DE),
      icon: Icons.mobile_friendly_outlined,
      screenshots: [
        'assets/teman_muslim/temanmuslim_home.webp',
        'assets/teman_muslim/temanmuslim_alquran.webp',
        'assets/teman_muslim/temanmuslim_sholat.webp',
        'assets/teman_muslim/temanmuslim_fatwa.webp',
        'assets/teman_muslim/temanmuslim_haji_umroh.webp',
      ],
    ),
    PortfolioProject(
      title: 'HiredToday',
      subtitle: 'PT Ponseljobs Indonesia | Mobile Developer',
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
      title: 'RecyThing',
      subtitle: 'Alterra Academy | Capstone Project',
      period: 'Bloc/Cubit learning project',
      description:
          'Built RecyThing, an environmental mobile app using Flutter with Bloc/Cubit architecture, a gamified mission system, backend integrations, and GitHub-based version control.',
      accent: Color(0xFFE9E2D7),
      icon: Icons.eco_outlined,
      screenshots: [
        'assets/recything/recything.jpg',
        'assets/recything/recything_introduction.jpg',
        'assets/recything/recything_core_features.jpg',
      ],
      screenshotType: ScreenshotType.landscape,
    ),
  ];

  static const List<PortfolioSkill> skills = [
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

  static const List<ContactLink> contacts = [
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
}
