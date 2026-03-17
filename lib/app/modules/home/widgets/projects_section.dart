import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/modules/home/controllers/home_controller.dart';

import 'section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({required this.projects, super.key});

  final List<PortfolioProject> projects;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1040;
    final isTablet = width >= 760;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            eyebrow: 'Selected Experience',
            title: 'Recent roles and production work across mobile teams.',
            description:
                'A short overview of hands-on Flutter experience across recruitment, superapp, and academy environments, with focus on architecture, API integration, and collaboration.',
          ),
          const SizedBox(height: 28),
          if (projects.isNotEmpty)
            _FeaturedExperienceCard(project: projects.first),
          const SizedBox(height: 20),
          if (projects.length > 1)
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _ExperienceCard(
                          project: projects[1],
                          index: 2,
                          compact: false,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            if (projects.length > 2)
                              _ExperienceCard(
                                project: projects[2],
                                index: 3,
                                compact: true,
                              ),
                            if (projects.length > 3) ...[
                              const SizedBox(height: 20),
                              _ExperienceCard(
                                project: projects[3],
                                index: 4,
                                compact: true,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      for (var i = 1; i < projects.length; i++) ...[
                        _ExperienceCard(
                          project: projects[i],
                          index: i + 1,
                          compact: isTablet,
                        ),
                        if (i != projects.length - 1)
                          const SizedBox(height: 20),
                      ],
                    ],
                  ),
        ],
      ),
    );
  }
}

// ── Featured Card ─────────────────────────────────────────────────────────────

class _FeaturedExperienceCard extends StatefulWidget {
  const _FeaturedExperienceCard({required this.project});

  final PortfolioProject project;

  @override
  State<_FeaturedExperienceCard> createState() =>
      _FeaturedExperienceCardState();
}

class _FeaturedExperienceCardState extends State<_FeaturedExperienceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 760;
    final textTheme = Theme.of(context).textTheme;
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
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: const Color(0xFFEEEAE3)),
          boxShadow: _hovering
              ? const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 30,
                    offset: Offset(0, 18),
                  ),
                ]
              : const [],
        ),
        child: isMobile
            ? _FeaturedCardMobile(project: project, textTheme: textTheme)
            : _FeaturedCardDesktop(
                project: project,
                textTheme: textTheme,
                hasScreenshots: hasScreenshots,
              ),
      ),
    );
  }
}

// ── Featured Card Desktop ─────────────────────────────────────────────────────

class _FeaturedCardDesktop extends StatelessWidget {
  const _FeaturedCardDesktop({
    required this.project,
    required this.textTheme,
    required this.hasScreenshots,
  });

  final PortfolioProject project;
  final TextTheme textTheme;
  final bool hasScreenshots;

  @override
  Widget build(BuildContext context) {
    if (!hasScreenshots) {
      return _FeaturedCardInfo(project: project, textTheme: textTheme);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 320,
          height: 420,
          child: _ScreenshotStrip(project: project),
        ),
        const SizedBox(width: 28),
        Expanded(
          child: _FeaturedCardInfo(project: project, textTheme: textTheme),
        ),
      ],
    );
  }
}

class _ScreenshotStrip extends StatefulWidget {
  const _ScreenshotStrip({required this.project});

  final PortfolioProject project;

  @override
  State<_ScreenshotStrip> createState() => _ScreenshotStripState();
}

class _ScreenshotStripState extends State<_ScreenshotStrip> {
  int _current = 0;

  void _openLightbox(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierColor: const Color(0xE6000000),
      builder: (_) => _LightboxDialog(
        screenshots: widget.project.screenshots,
        initialIndex: index,
      ),
    );
  }

  List<int> _visibleIndices() {
    final total = widget.project.screenshots.length;
    final prev = (_current - 1 + total) % total;
    final next = (_current + 1) % total;
    return [prev, _current, next];
  }

  @override
  Widget build(BuildContext context) {
    final screenshots = widget.project.screenshots;
    final total = screenshots.length;
    final indices = _visibleIndices();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.project.accent,
            widget.project.accent.withOpacity(0.25),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _StripPhone(
                  assetPath: screenshots[indices[0]],
                  heightFactor: 0.82,
                  onTap: () {
                    setState(() => _current = indices[0]);
                    _openLightbox(context, indices[0]);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StripPhone(
                  assetPath: screenshots[indices[1]],
                  heightFactor: 1.0,
                  isCenter: true,
                  onTap: () => _openLightbox(context, indices[1]),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StripPhone(
                  assetPath: screenshots[indices[2]],
                  heightFactor: 0.82,
                  onTap: () {
                    setState(() => _current = indices[2]);
                    _openLightbox(context, indices[2]);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CarouselButton(
                icon: Icons.chevron_left_rounded,
                onTap: () =>
                    setState(() => _current = (_current - 1 + total) % total),
                tinted: true,
              ),
              const SizedBox(width: 12),
              ...List.generate(
                total,
                (i) => _DotIndicator(active: i == _current, tinted: true),
              ),
              const SizedBox(width: 12),
              _CarouselButton(
                icon: Icons.chevron_right_rounded,
                onTap: () => setState(() => _current = (_current + 1) % total),
                tinted: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StripPhone extends StatefulWidget {
  const _StripPhone({
    required this.assetPath,
    required this.heightFactor,
    required this.onTap,
    this.isCenter = false,
  });

  final String assetPath;
  final double heightFactor;
  final VoidCallback onTap;
  final bool isCenter;

  @override
  State<_StripPhone> createState() => _StripPhoneState();
}

class _StripPhoneState extends State<_StripPhone> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = w * 2.1 * widget.heightFactor;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..translateByDouble(0, _hovering ? -6 : 0, 0, 1),
              child: _PhoneMockup(
                key: ValueKey(widget.assetPath),
                assetPath: widget.assetPath,
                width: w,
                height: h,
                lightBackground: true,
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Featured Card Mobile ──────────────────────────────────────────────────────

class _FeaturedCardMobile extends StatelessWidget {
  const _FeaturedCardMobile({required this.project, required this.textTheme});

  final PortfolioProject project;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FeaturedCardInfo(project: project, textTheme: textTheme),
        if (project.screenshots.isNotEmpty) ...[
          const SizedBox(height: 24),
          _ScreenshotStrip(project: project),
        ],
      ],
    );
  }
}

// ── Card Info (text side) ─────────────────────────────────────────────────────

class _FeaturedCardInfo extends StatelessWidget {
  const _FeaturedCardInfo({required this.project, required this.textTheme});

  final PortfolioProject project;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionToken(label: '01', dark: true),
          const SizedBox(height: 20),
          Text(
            project.title,
            style: textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF1D1D1D),
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            project.subtitle,
            style: textTheme.titleSmall?.copyWith(
              color: const Color(0xFF5D5954),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F8F5),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFECE8E2)),
            ),
            child: Text(
              project.period,
              style: textTheme.bodySmall?.copyWith(
                color: const Color(0xFF3A3834),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            project.description,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF5F5A55),
              height: 1.75,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F8F5),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEFEBE4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.auto_awesome_outlined,
                    size: 18,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Focused on scalable delivery, API-connected flows, and production-ready mobile feature rollout.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF5F5A55),
                      height: 1.65,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Screenshot Carousel ───────────────────────────────────────────────────────

class _CarouselButton extends StatelessWidget {
  const _CarouselButton({
    required this.icon,
    required this.onTap,
    this.tinted = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: enabled ? 1.0 : 0.28,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: tinted
                ? Colors.white.withOpacity(0.7)
                : const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: tinted
                  ? Colors.white.withOpacity(0.5)
                  : const Color(0xFFE2DDD7),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: const Color(0xFF2D2D2D)),
        ),
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.active, this.tinted = false});

  final bool active;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: active ? 18 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active
            ? (tinted ? Colors.white : const Color(0xFF2D2D2D))
            : (tinted
                  ? Colors.white.withOpacity(0.4)
                  : const Color(0xFFD5D0CA)),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

// ── Lightbox ──────────────────────────────────────────────────────────────────

class _LightboxDialog extends StatefulWidget {
  const _LightboxDialog({
    required this.screenshots,
    required this.initialIndex,
  });

  final List<String> screenshots;
  final int initialIndex;

  @override
  State<_LightboxDialog> createState() => _LightboxDialogState();
}

class _LightboxDialogState extends State<_LightboxDialog> {
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
  }

  void _prev() {
    if (_current > 0) setState(() => _current--);
  }

  void _next() {
    if (_current < widget.screenshots.length - 1) setState(() => _current++);
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.screenshots.length;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {},
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _CarouselButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: _current > 0 ? _prev : null,
                    ),
                    const SizedBox(width: 20),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.06, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      ),
                      child: _PhoneMockup(
                        key: ValueKey(_current),
                        assetPath: widget.screenshots[_current],
                        width: 240,
                        height: 460,
                        lightBackground: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    _CarouselButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: _current < total - 1 ? _next : null,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    total,
                    (i) => _DotIndicator(active: i == _current),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: const Color(0x55FFFFFF)),
                    ),
                    child: Text(
                      'Close',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Phone Mockup ──────────────────────────────────────────────────────────────

class _PhoneMockup extends StatelessWidget {
  const _PhoneMockup({
    required this.assetPath,
    required this.width,
    required this.height,
    this.lightBackground = false,
    super.key,
  });

  final String assetPath;
  final double width;
  final double height;
  final bool lightBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.12),
        border: lightBackground
            ? null
            : Border.all(color: const Color(0xFFDDD9D3), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

// ── Experience Card ───────────────────────────────────────────────────────────

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard({
    required this.project,
    required this.index,
    required this.compact,
  });

  final PortfolioProject project;
  final int index;
  final bool compact;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0, _hovering ? -5 : 0, 0, 1),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFEEEAE3)),
          boxShadow: _hovering
              ? const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 26,
                    offset: Offset(0, 16),
                  ),
                ]
              : const [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionToken(label: '0${widget.index}'),
                      const SizedBox(height: 16),
                      Text(
                        project.title,
                        style: textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF1D1D1D),
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.subtitle,
                        style: textTheme.titleSmall?.copyWith(
                          color: const Color(0xFF5D5954),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Transform.rotate(
                  angle: widget.compact ? -0.05 : 0.05,
                  child: Container(
                    width: widget.compact ? 72 : 86,
                    height: widget.compact ? 72 : 86,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [project.accent, Colors.white],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      project.icon,
                      color: const Color(0xFF2D2D2D),
                      size: widget.compact ? 30 : 34,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F8F5),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                project.description,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF66625E),
                  height: 1.7,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFFEAE7E1)),
                ),
                child: Text(
                  project.period,
                  style: textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF57534E),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section Token ─────────────────────────────────────────────────────────────

class _SectionToken extends StatelessWidget {
  const _SectionToken({required this.label, this.dark = false});

  final String label;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF191919) : const Color(0xFFF8F8F5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: dark ? Colors.transparent : const Color(0xFFECE8E2),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: dark ? Colors.white : const Color(0xFF5D5955),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
