import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';
import 'package:personal_portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:personal_portfolio/app/modules/home/widgets/projects/screenshot_strip.dart';
import 'package:personal_portfolio/app/modules/home/widgets/shared/section_token.dart';

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

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0, _hovering ? -6 : 0, 0, 1),
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFFFFF), Color(0xFFFFFCF6)],
          ),
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: const Color(0xFFEEEAE3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12DAD2C7),
              blurRadius: 40,
              offset: Offset(0, 24),
            ),
          ],
        ).copyWith(
          boxShadow: _hovering
              ? const [
                  BoxShadow(
                    color: Color(0x12DAD2C7),
                    blurRadius: 40,
                    offset: Offset(0, 24),
                  ),
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 30,
                    offset: Offset(0, 18),
                  ),
                ]
              : const [],
        ),
        child: isMobile
            ? _FeaturedCardMobile(project: project)
            : _FeaturedCardDesktop(
                project: project,
                hasScreenshots: hasScreenshots,
                compactInfo: isTablet,
              ),
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
        const SizedBox(width: 28),
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
          const SizedBox(height: 24),
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
          padding: const EdgeInsets.only(top: 8),
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
                  color: const Color(0xFF1D1D1D),
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                project.subtitle,
                style: textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF5D5954),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 18),
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
              const SizedBox(height: 24),
              Text(
                project.description,
                style: textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF5F5A55),
                  height: 1.72,
                ),
              ),
              if (hasGooglePlayUrl || hasAppStoreUrl) ...[
                const SizedBox(height: 28),
                if (useSplitCtas && hasGooglePlayUrl && hasAppStoreUrl)
                  Row(
                    children: [
                      Expanded(
                        child: _StoreButton(
                          appName: project.title,
                          label: project.externalLabel,
                          variant: _StoreButtonVariant.googlePlay,
                          icon: FontAwesomeIcons.googlePlay,
                          fillWidth: true,
                          onTap: () => Get.find<HomeController>().openUrl(
                            project.externalUrl,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StoreButton(
                          appName: project.title,
                          label: project.secondaryExternalLabel,
                          variant: _StoreButtonVariant.appStore,
                          icon: FontAwesomeIcons.appStoreIos,
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
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      if (hasGooglePlayUrl)
                        _StoreButton(
                          appName: project.title,
                          label: project.externalLabel,
                          variant: _StoreButtonVariant.googlePlay,
                          icon: FontAwesomeIcons.googlePlay,
                          onTap: () => Get.find<HomeController>().openUrl(
                            project.externalUrl,
                          ),
                        ),
                      if (hasAppStoreUrl)
                        _StoreButton(
                          appName: project.title,
                          label: project.secondaryExternalLabel,
                          variant: _StoreButtonVariant.appStore,
                          icon: FontAwesomeIcons.appStoreIos,
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
        color: const Color(0xFFF9F8F5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFECE8E2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF4D4944)),
          const SizedBox(width: 8),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: const Color(0xFF3A3834),
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
        color: const Color(0xFF1F1E1B),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 7),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: Colors.white,
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
    required this.icon,
    required this.onTap,
    this.fillWidth = false,
  });

  final String appName;
  final String label;
  final _StoreButtonVariant variant;
  final FaIconData icon;
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
    final isGooglePlay = widget.variant == _StoreButtonVariant.googlePlay;
    final gradientColors = isGooglePlay
        ? (_hovering
            ? const [Color(0xFFFFFFFF), Color(0xFFF1EEE8)]
            : const [Color(0xFFFFFEFC), Color(0xFFF5F1EB)])
        : (_hovering
            ? const [Color(0xFF1D1D1D), Color(0xFF343434)]
            : const [Color(0xFF242424), Color(0xFF3A3A3A)]);
    final borderColor = isGooglePlay
        ? const Color(0xFFD9D1C6).withValues(alpha: _hovering ? 0.96 : 0.86)
        : const Color(0xFFE5DED5).withValues(alpha: _hovering ? 0.18 : 0.1);
    final iconSurfaceColor = isGooglePlay
        ? const Color(0xFFF1ECE5)
        : const Color(0xFFFFFFFF).withValues(alpha: _hovering ? 0.16 : 0.1);
    final iconBorderColor = isGooglePlay
        ? const Color(0xFFD9D1C7)
        : const Color(0xFFFFFFFF).withValues(alpha: _hovering ? 0.2 : 0.12);
    final iconColor =
        isGooglePlay ? const Color(0xFF353532) : const Color(0xFFF6F3EF);
    final caption = isGooglePlay ? 'Google Play' : 'App Store';
    final textColor =
        isGooglePlay ? const Color(0xFF2F312E) : const Color(0xFFFFFFFF);
    final captionColor = isGooglePlay
        ? const Color(0xFF66615B)
        : Colors.white.withValues(alpha: 0.78);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          width: widget.fillWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: isGooglePlay
                          ? const Color(0x12C9C0B6)
                          : const Color(0x14000000),
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
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: iconBorderColor,
                  ),
                ),
                alignment: Alignment.center,
                child: FaIcon(
                  widget.icon,
                  size: 16,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 12),
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
                color: isGooglePlay ? const Color(0xFF3B3A37) : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
