import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';

import '../shared/portfolio_button.dart';
import 'hero_badges.dart';
import 'hero_profile_panel.dart';

class HeroDesktop extends StatelessWidget {
  const HeroDesktop({
    required this.name,
    required this.role,
    required this.headline,
    required this.summary,
    required this.onViewWork,
    required this.onContact,
    required this.onDownloadCv,
    super.key,
  });

  final String name;
  final String role;
  final String headline;
  final String summary;
  final VoidCallback onViewWork;
  final VoidCallback onContact;
  final VoidCallback onDownloadCv;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Wrap(
                spacing: 14,
                runSpacing: 14,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  AvatarBadge(),
                  InfoPill(
                    label: 'Jakarta, Indonesia',
                    icon: Icons.place_outlined,
                  ),
                  AvailabilityPill(),
                ],
              ),
              const SizedBox(height: 34),
              Text(
                name,
                style: textTheme.displayLarge?.copyWith(
                  fontSize: 74,
                  height: 0.96,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textStrong,
                  letterSpacing: -2.6,
                ),
              ),
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Flutter-focused '),
                    TextSpan(
                      text: role,
                      style: const TextStyle(color: AppColors.accentWarm),
                    ),
                    const TextSpan(text: ' crafting reliable mobile apps.'),
                  ],
                ),
                style: textTheme.headlineMedium?.copyWith(
                  fontSize: 40,
                  height: 1.12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFB8B1AB),
                  letterSpacing: -1.2,
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  headline,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.textMuted,
                    height: 1.8,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  PortfolioButton(
                    label: 'View experience',
                    primary: true,
                    onTap: onViewWork,
                  ),
                  PortfolioButton(
                    label: 'Download CV',
                    icon: Icons.download_rounded,
                    onTap: onDownloadCv,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 28),
        Expanded(flex: 4, child: HeroProfilePanel(summary: summary)),
      ],
    );
  }
}

class HeroMobile extends StatelessWidget {
  const HeroMobile({
    required this.name,
    required this.role,
    required this.headline,
    required this.summary,
    required this.onViewWork,
    required this.onContact,
    required this.onDownloadCv,
    super.key,
  });

  final String name;
  final String role;
  final String headline;
  final String summary;
  final VoidCallback onViewWork;
  final VoidCallback onContact;
  final VoidCallback onDownloadCv;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Wrap(
          spacing: 14,
          runSpacing: 14,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AvatarBadge(),
            InfoPill(label: 'Jakarta, Indonesia', icon: Icons.place_outlined),
            AvailabilityPill(),
          ],
        ),
        const SizedBox(height: 26),
        Text(
          name,
          style: textTheme.displayLarge?.copyWith(
            fontSize: 46,
            height: 1.02,
            fontWeight: FontWeight.w700,
            color: AppColors.textStrong,
            letterSpacing: -1.4,
          ),
        ),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Flutter-focused '),
              TextSpan(
                text: role,
                style: const TextStyle(color: AppColors.accentWarm),
              ),
              const TextSpan(text: ' crafting reliable mobile apps.'),
            ],
          ),
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 28,
            height: 1.12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFB8B1AB),
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          headline,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.textMuted,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            PortfolioButton(
              label: 'View experience',
              primary: true,
              onTap: onViewWork,
            ),
            PortfolioButton(
              label: 'Download CV',
              icon: Icons.download_rounded,
              onTap: onDownloadCv,
            ),
          ],
        ),
        const SizedBox(height: 24),
        HeroProfilePanel(summary: summary),
      ],
    );
  }
}
