import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class TopNavigation extends StatefulWidget {
  const TopNavigation({
    required this.onTapHero,
    required this.onTapProjects,
    required this.onTapContact,
    super.key,
  });

  final VoidCallback onTapHero;
  final VoidCallback onTapProjects;
  final VoidCallback onTapContact;

  @override
  State<TopNavigation> createState() => _TopNavigationState();
}

class _TopNavigationState extends State<TopNavigation> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 920;
    final controller = Get.find<HomeController>();

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 36,
        isMobile ? 12 : 24,
        isMobile ? 20 : 36,
        8,
      ),
      child: Obx(
        () {
          final isScrolled = controller.isScrolled.value;
          final borderRadius = BorderRadius.circular(isScrolled ? 26 : 20);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: isScrolled
                  ? (isMobile ? 14 : 18)
                  : (isMobile ? 4 : 2),
              vertical: isScrolled
                  ? (isMobile ? 12 : 0)
                  : 4,
            ),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: isScrolled
                      ? const Color(0x16D8D0C5)
                      : const Color(0x00D8D0C5),
                  blurRadius: isScrolled ? 28 : 0,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: isScrolled ? 18 : 0,
                  sigmaY: isScrolled ? 18 : 0,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 420),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(
                    horizontal: isScrolled
                        ? (isMobile ? 14 : 18)
                        : (isMobile ? 8 : 0),
                    vertical: isScrolled
                        ? (isMobile ? 12 : 14)
                        : 8,
                  ),
                  decoration: BoxDecoration(
                    color: isScrolled
                        ? const Color(0xA8FFFFFF)
                        : const Color(0x00FFFFFF),
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: isScrolled
                          ? const Color(0xBFE7E0D5)
                          : const Color(0x00E7E0D5),
                    ),
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeOutCubic,
                        height: isMobile
                            ? (isScrolled ? 48 : 54)
                            : 48,
                        width: isMobile
                            ? (isScrolled ? 48 : 54)
                            : 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF171717), Color(0xFF33312E)],
                          ),
                          borderRadius: BorderRadius.circular(
                            isScrolled ? 18 : 20,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'FA',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      if (!isMobile)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ferdy Apriliyanto',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xFF201F1C),
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 260),
                              curve: Curves.easeOutCubic,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF78716A),
                                    fontWeight: FontWeight.w600,
                                  ) ??
                                  const TextStyle(),
                              child: Text(
                                isScrolled
                                    ? 'Building production-ready Flutter apps'
                                    : 'Flutter mobile developer',
                              ),
                            ),
                          ],
                        ),
                      const Spacer(),
                      if (!isMobile) ...[
                        _NavButton(
                          key: const ValueKey('nav_home'),
                          label: 'Home',
                          active: controller.activeSection.value == 'home',
                          onTap: widget.onTapHero,
                        ),
                        _NavButton(
                          key: const ValueKey('nav_experience'),
                          label: 'Experience',
                          active: controller.activeSection.value == 'experience',
                          onTap: widget.onTapProjects,
                        ),
                        _NavButton(
                          key: const ValueKey('nav_contact'),
                          label: 'Contact',
                          active: controller.activeSection.value == 'contact',
                          onTap: widget.onTapContact,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 320),
                          width: isScrolled ? 14 : 18,
                        ),
                        GestureDetector(
                          onTap: () =>
                              controller.openUrl(HomeController.whatsappUrl),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.easeOutCubic,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: [
                                BoxShadow(
                                  color: isScrolled
                                      ? const Color(0x14000000)
                                      : const Color(0x1A000000),
                                  blurRadius: isScrolled ? 10 : 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Text(
                              'Let\'s talk',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ] else
                        GestureDetector(
                          onTap: controller.toggleMenu,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.easeOutCubic,
                            width: isScrolled ? 50 : 54,
                            height: isScrolled ? 50 : 54,
                            decoration: BoxDecoration(
                              gradient: controller.isMenuOpen.value
                                  ? const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF171717),
                                        Color(0xFF312F2C),
                                      ],
                                    )
                                  : const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFFFDFC),
                                        Color(0xFFF1E8DA),
                                      ],
                                    ),
                              borderRadius: BorderRadius.circular(
                                isScrolled ? 18 : 20,
                              ),
                              border: Border.all(
                                color: controller.isMenuOpen.value
                                    ? const Color(0xFF2D2B28)
                                    : const Color(0xFFE0D4C4),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: _HamburgerGlyph(
                              open: controller.isMenuOpen.value,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HamburgerGlyph extends StatelessWidget {
  const _HamburgerGlyph({required this.open});

  final bool open;

  @override
  Widget build(BuildContext context) {
    final lineColor = open ? Colors.white : const Color(0xFF1F1D1A);

    return SizedBox(
      width: 24,
      height: 24,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        ),
        child: open
            ? Icon(
                Icons.close_rounded,
                key: const ValueKey('close_glyph'),
                size: 20,
                color: lineColor,
              )
            : Column(
                key: const ValueKey('menu_glyph'),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _HamburgerLine(width: 19, color: lineColor),
                  const SizedBox(height: 4),
                  _HamburgerLine(width: 13, color: lineColor),
                  const SizedBox(height: 4),
                  _HamburgerLine(width: 17, color: lineColor),
                ],
              ),
      ),
    );
  }
}

class _HamburgerLine extends StatelessWidget {
  const _HamburgerLine({required this.width, required this.color});

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: 2.4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  const _NavButton({
    required this.label,
    required this.onTap,
    required this.active,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: widget.active
                ? const Color(0xFFF5EFE6)
                : const Color(0x00F5EFE6),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: widget.active
                  ? const Color(0xFFE6DCCE)
                  : const Color(0x00E6DCCE),
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: widget.active
                  ? const Color(0xFF1F1D1A)
                  : _hovering
                  ? const Color(0xFFAAAAAA)
                  : const Color(0xFF353535),
              fontWeight: widget.active ? FontWeight.w700 : FontWeight.w600,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
