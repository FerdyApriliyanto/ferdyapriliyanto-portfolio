import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:personal_portfolio/app/modules/home/widgets/experiences/screenshot_strip.dart';
import 'package:personal_portfolio/app/modules/home/widgets/shared/section_token.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';
import 'package:personal_portfolio/app/theme/app_durations.dart';
import 'package:personal_portfolio/app/theme/app_gradients.dart';
import 'package:personal_portfolio/app/theme/app_radius.dart';
import 'package:personal_portfolio/app/theme/app_shadows.dart';
import 'package:personal_portfolio/app/theme/app_spacing.dart';

class FeaturedExperienceCard extends StatefulWidget {
  const FeaturedExperienceCard({required this.project, super.key});

  final PortfolioProject project;

  @override
  State<FeaturedExperienceCard> createState() => _FeaturedExperienceCardState();
}

class _FeaturedExperienceCardState extends State<FeaturedExperienceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;
    final isTablet = MediaQuery.sizeOf(context).width < 1040;
    final project = widget.project;
    final hasScreenshots = project.screenshots.isNotEmpty;
    final cardDecoration = BoxDecoration(
      gradient: AppGradients.heroSurface,
      borderRadius: BorderRadius.circular(34),
      border: Border.all(color: AppColors.border),
      boxShadow: isMobile ? null : AppShadows.featuredCard,
    ).copyWith(
      boxShadow: !isMobile && _hovering ? AppShadows.featuredCardHover : null,
    );

    final child = isMobile
        ? _FeaturedCardMobile(project: project)
        : _FeaturedCardDesktop(
            project: project,
            hasScreenshots: hasScreenshots,
            compactInfo: isTablet,
          );

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.pageMobile),
        decoration: cardDecoration,
        child: child,
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0, _hovering ? -6 : 0, 0, 1),
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: cardDecoration,
        child: child,
      ),
    );
  }
}

class _FeaturedCardDesktop extends StatelessWidget {
  const _FeaturedCardDesktop({
    required this.project,
    required this.hasScreenshots,
    required this.compactInfo,
  });

  final PortfolioProject project;
  final bool hasScreenshots;
  final bool compactInfo;

  @override
  Widget build(BuildContext context) {
    if (!hasScreenshots) {
      return _FeaturedCardInfo(project: project);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(child: ScreenshotStrip(project: project)),
        ),
        const SizedBox(width: AppSpacing.xxl),
        Expanded(
          child: _FeaturedCardInfo(
            project: project,
            featured: true,
            compact: compactInfo,
          ),
        ),
      ],
    );
  }
}

class _FeaturedCardMobile extends StatelessWidget {
  const _FeaturedCardMobile({required this.project});

  final PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FeaturedCardInfo(project: project, featured: true),
        if (project.screenshots.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          ScreenshotStrip(project: project),
        ],
      ],
    );
  }
}

class _FeaturedCardInfo extends StatelessWidget {
  const _FeaturedCardInfo({
    required this.project,
    this.featured = false,
    this.compact = false,
  });

  final PortfolioProject project;
  final bool featured;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenshotLabel = project.screenshotType == ScreenshotType.landscape
        ? 'Landscape showcase'
        : 'Mobile flows';
    final hasGooglePlayUrl = project.externalUrl.trim().isNotEmpty;
    final hasAppStoreUrl = project.secondaryExternalUrl.trim().isNotEmpty;

    return LayoutBuilder(
      builder: (context, constraints) {
        final useSplitCtas = constraints.maxWidth >= 520;

        return Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const SectionToken(label: '01', dark: true),
                  if (featured)
                    _MicroBadge(
                      icon: Icons.workspace_premium_outlined,
                      label: 'Featured Build',
                    ),
                ],
              ),
              const SizedBox(height: 26),
              Text(
                project.title,
                style: textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                project.subtitle,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _InfoChip(
                    label: project.period,
                    icon: Icons.schedule_outlined,
                  ),
                  _InfoChip(
                    label: screenshotLabel,
                    icon: Icons.photo_library_outlined,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                project.description,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textMuted,
                  height: 1.72,
                ),
              ),
              if (hasGooglePlayUrl || hasAppStoreUrl) ...[
                const SizedBox(height: AppSpacing.xxl),
                if (useSplitCtas && hasGooglePlayUrl && hasAppStoreUrl)
                  Row(
                    children: [
                      Expanded(
                        child: _StoreButton(
                          appName: project.title,
                          label: project.externalLabel,
                          variant: _StoreButtonVariant.googlePlay,
                          fillWidth: true,
                          onTap: () => Get.find<HomeController>().openUrl(
                            project.externalUrl,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _StoreButton(
                          appName: project.title,
                          label: project.secondaryExternalLabel,
                          variant: _StoreButtonVariant.appStore,
                          fillWidth: true,
                          onTap: () => Get.find<HomeController>().openUrl(
                            project.secondaryExternalUrl,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      if (hasGooglePlayUrl)
                        _StoreButton(
                          appName: project.title,
                          label: project.externalLabel,
                          variant: _StoreButtonVariant.googlePlay,
                          onTap: () => Get.find<HomeController>().openUrl(
                            project.externalUrl,
                          ),
                        ),
                      if (hasAppStoreUrl)
                        _StoreButton(
                          appName: project.title,
                          label: project.secondaryExternalLabel,
                          variant: _StoreButtonVariant.appStore,
                          onTap: () => Get.find<HomeController>().openUrl(
                            project.secondaryExternalUrl,
                          ),
                        ),
                    ],
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.textStrong,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MicroBadge extends StatelessWidget {
  const _MicroBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.brandDark,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.onDark),
          const SizedBox(width: 7),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.onDark,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

enum _StoreButtonVariant { googlePlay, appStore }

class _StoreButton extends StatefulWidget {
  const _StoreButton({
    required this.appName,
    required this.label,
    required this.variant,
    required this.onTap,
    this.fillWidth = false,
  });

  final String appName;
  final String label;
  final _StoreButtonVariant variant;
  final VoidCallback onTap;
  final bool fillWidth;

  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMobile = MediaQuery.sizeOf(context).width < 760;
    final isGooglePlay = widget.variant == _StoreButtonVariant.googlePlay;
    final gradientColors = isGooglePlay
        ? (_hovering
            ? AppGradients.storeGooglePlayHover.colors
            : AppGradients.storeGooglePlay.colors)
        : (_hovering
            ? AppGradients.storeAppStoreHover.colors
            : AppGradients.storeAppStore.colors);
    final borderColor = isGooglePlay
        ? AppColors.borderWarm.withValues(alpha: _hovering ? 0.96 : 0.86)
        : AppColors.borderWarm.withValues(alpha: _hovering ? 0.18 : 0.1);
    final iconSurfaceColor = isGooglePlay
        ? const Color(0xFFF1ECE5)
        : AppColors.surface.withValues(alpha: _hovering ? 0.16 : 0.1);
    final iconBorderColor = isGooglePlay
        ? AppColors.borderWarm
        : AppColors.surface.withValues(alpha: _hovering ? 0.2 : 0.12);
    final iconColor =
        isGooglePlay ? AppColors.textTertiary : AppColors.onDarkMuted;
    final caption = isGooglePlay ? 'Google Play' : 'App Store';
    final textColor =
        isGooglePlay ? const Color(0xFF2F312E) : AppColors.onDark;
    final captionColor = isGooglePlay
        ? const Color(0xFF66615B)
        : AppColors.onDark.withValues(alpha: 0.78);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          curve: Curves.easeOutCubic,
          width: widget.fillWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.lg),
            border: Border.all(color: borderColor),
            boxShadow: !isMobile && _hovering
                ? [
                    BoxShadow(
                      color: isGooglePlay
                          ? AppColors.borderWarm.withValues(alpha: 0.72)
                          : AppColors.shadowSoft.withValues(alpha: 0.16),
                      blurRadius: 22,
                      offset: const Offset(0, 12),
                    ),
                  ]
                : const [],
          ),
          child: Row(
            mainAxisSize:
                widget.fillWidth ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: iconSurfaceColor,
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                  border: Border.all(
                    color: iconBorderColor,
                  ),
                ),
                alignment: Alignment.center,
                child: _StoreLogo(
                  variant: widget.variant,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      caption,
                      strutStyle: const StrutStyle(
                        forceStrutHeight: true,
                        height: 1.2,
                      ),
                      style: textTheme.labelSmall?.copyWith(
                        color: captionColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      strutStyle: const StrutStyle(
                        forceStrutHeight: true,
                        height: 1.2,
                      ),
                      style: textTheme.titleMedium?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.open_in_new_rounded,
                size: 18,
                color: isGooglePlay ? const Color(0xFF3B3A37) : AppColors.onDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoreLogo extends StatelessWidget {
  const _StoreLogo({required this.variant, required this.color});

  final _StoreButtonVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (variant == _StoreButtonVariant.appStore) {
      return Icon(Icons.apple_rounded, size: 18, color: color);
    }

    return Icon(Icons.play_arrow_rounded, size: 18, color: color);
  }
}
