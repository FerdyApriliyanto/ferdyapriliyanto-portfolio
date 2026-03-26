import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/portfolio_project.dart';

import '../shared/carousel_controls.dart';
import '../shared/phone_mockup.dart';
import 'lightbox_dialog.dart';

class ScreenshotStrip extends StatefulWidget {
  const ScreenshotStrip({required this.project, super.key});

  final PortfolioProject project;

  @override
  State<ScreenshotStrip> createState() => _ScreenshotStripState();
}

class _ScreenshotStripState extends State<ScreenshotStrip> {
  int _current = 0;

  void _openLightbox(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierColor: const Color(0xE6000000),
      builder: (_) => LightboxDialog(
        screenshots: widget.project.screenshots,
        initialIndex: index,
        screenshotType: widget.project.screenshotType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;
    final screenshots = widget.project.screenshots;
    final total = screenshots.length;
    final isLandscape =
        widget.project.screenshotType == ScreenshotType.landscape;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 18 : 24,
        horizontal: isMobile ? 12 : 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.project.accent,
            widget.project.accent.withValues(alpha: 0.25),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          if (isMobile)
            _SinglePreview(
              screenshots: screenshots,
              current: _current,
              screenshotType: widget.project.screenshotType,
              onTap: () => _openLightbox(context, _current),
            )
          else if (isLandscape)
            _LandscapePreview(
              screenshots: screenshots,
              current: _current,
              screenshotType: widget.project.screenshotType,
              onTap: () => _openLightbox(context, _current),
            )
          else
            _PortraitPreviewStrip(
              screenshots: screenshots,
              current: _current,
              screenshotType: widget.project.screenshotType,
              onTap: (index) => _openLightbox(context, index),
            ),
          SizedBox(height: isLandscape ? 24 : 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselButton(
                icon: Icons.chevron_left_rounded,
                onTap: () =>
                    setState(() => _current = (_current - 1 + total) % total),
                tinted: true,
              ),
              const SizedBox(width: 12),
              ...List.generate(
                total,
                (i) => DotIndicator(active: i == _current, tinted: true),
              ),
              const SizedBox(width: 12),
              CarouselButton(
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

class _SinglePreview extends StatelessWidget {
  const _SinglePreview({
    required this.screenshots,
    required this.current,
    required this.screenshotType,
    required this.onTap,
  });

  final List<String> screenshots;
  final int current;
  final ScreenshotType screenshotType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = screenshotType == ScreenshotType.landscape;
        final previewWidth = constraints.maxWidth;
        final previewHeight = isLandscape
            ? (previewWidth / 1.625).clamp(180.0, 240.0)
            : (previewWidth * 1.42).clamp(240.0, 420.0);

        return Center(
          child: SizedBox(
            width: previewWidth,
            child: _StripPhone(
              assetPath: screenshots[current],
              height: previewHeight,
              screenshotType: screenshotType,
              onTap: onTap,
            ),
          ),
        );
      },
    );
  }
}

class _PortraitPreviewStrip extends StatelessWidget {
  const _PortraitPreviewStrip({
    required this.screenshots,
    required this.current,
    required this.screenshotType,
    required this.onTap,
  });

  final List<String> screenshots;
  final int current;
  final ScreenshotType screenshotType;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final total = screenshots.length;
    final prev = (current - 1 + total) % total;
    final next = (current + 1) % total;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = (constraints.maxWidth - 16) / 3;
        final centerHeight = availableWidth * 1.82;
        final sideHeight = centerHeight * 0.82;
        final offset = (centerHeight - sideHeight) / 2;

        return Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, offset),
                  child: _StripPhone(
                    assetPath: screenshots[prev],
                    height: sideHeight,
                    screenshotType: screenshotType,
                    onTap: () => onTap(prev),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StripPhone(
                  assetPath: screenshots[current],
                  height: centerHeight,
                  screenshotType: screenshotType,
                  onTap: () => onTap(current),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, offset),
                  child: _StripPhone(
                    assetPath: screenshots[next],
                    height: sideHeight,
                    screenshotType: screenshotType,
                    onTap: () => onTap(next),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LandscapePreview extends StatelessWidget {
  const _LandscapePreview({
    required this.screenshots,
    required this.current,
    required this.screenshotType,
    required this.onTap,
  });

  final List<String> screenshots;
  final int current;
  final ScreenshotType screenshotType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final portraitReferenceHeight = ((constraints.maxWidth - 16) / 3) * 1.82;
        final frameHeight = portraitReferenceHeight.clamp(210.0, 276.0);
        final previewHeight = (frameHeight * 1).clamp(200.0, frameHeight);
        final previewWidth = (previewHeight * 1.625).clamp(
          0.0,
          constraints.maxWidth,
        );

        return Center(
          child: SizedBox(
            height: frameHeight,
            child: Center(
              child: SizedBox(
                width: previewWidth,
                child: _StripPhone(
                  assetPath: screenshots[current],
                  height: previewHeight,
                  screenshotType: screenshotType,
                  onTap: onTap,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StripPhone extends StatefulWidget {
  const _StripPhone({
    required this.assetPath,
    required this.height,
    required this.screenshotType,
    required this.onTap,
  });

  final String assetPath;
  final double height;
  final ScreenshotType screenshotType;
  final VoidCallback onTap;

  @override
  State<_StripPhone> createState() => _StripPhoneState();
}

class _StripPhoneState extends State<_StripPhone> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;
    return LayoutBuilder(
      builder: (context, constraints) {
        final phone = PhoneMockup(
          key: ValueKey(widget.assetPath),
          assetPath: widget.assetPath,
          width: constraints.maxWidth,
          height: widget.height,
          screenshotType: widget.screenshotType,
          lightBackground: true,
        );

        if (isMobile) {
          return GestureDetector(onTap: widget.onTap, child: phone);
        }

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..translateByDouble(0, _hovering ? -6 : 0, 0, 1),
              child: phone,
            ),
          ),
        );
      },
    );
  }
}
