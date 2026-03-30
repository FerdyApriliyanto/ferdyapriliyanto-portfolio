import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/modules/home/widgets/hero/hero_content.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';
import 'package:personal_portfolio/app/theme/app_durations.dart';
import 'package:personal_portfolio/app/theme/app_radius.dart';
import 'package:personal_portfolio/app/theme/app_shadows.dart';
import 'package:personal_portfolio/app/theme/app_spacing.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
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
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.slow,
  )..forward();

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 860;

    return FadeTransition(
      opacity: _fade,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 24, end: 0),
        duration: AppDurations.slow,
        curve: Curves.easeOutCubic,
        builder: (context, offset, child) =>
            Transform.translate(offset: Offset(0, offset), child: child),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: EdgeInsets.all(isMobile ? AppSpacing.xl : 36),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.panel),
            border: Border.all(color: AppColors.border),
            boxShadow: isMobile ? null : AppShadows.softPanel,
          ),
          child: isMobile
              ? HeroMobile(
                  name: widget.name,
                  role: widget.role,
                  headline: widget.headline,
                  summary: widget.summary,
                  onViewWork: widget.onViewWork,
                  onContact: widget.onContact,
                  onDownloadCv: widget.onDownloadCv,
                )
              : HeroDesktop(
                  name: widget.name,
                  role: widget.role,
                  headline: widget.headline,
                  summary: widget.summary,
                  onViewWork: widget.onViewWork,
                  onContact: widget.onContact,
                  onDownloadCv: widget.onDownloadCv,
                ),
        ),
      ),
    );
  }
}
