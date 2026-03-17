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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenshots = widget.project.screenshots;
    final total = screenshots.length;
    final prev = (_current - 1 + total) % total;
    final next = (_current + 1) % total;

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
            widget.project.accent.withValues(alpha: 0.25),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: _StripPhone(
                      assetPath: screenshots[prev],
                      heightFactor: 0.82,
                      onTap: () => _openLightbox(context, prev),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StripPhone(
                      assetPath: screenshots[_current],
                      heightFactor: 1.0,
                      isCenter: true,
                      onTap: () => _openLightbox(context, _current),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StripPhone(
                      assetPath: screenshots[next],
                      heightFactor: 0.82,
                      onTap: () => _openLightbox(context, next),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
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
              child: PhoneMockup(
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
