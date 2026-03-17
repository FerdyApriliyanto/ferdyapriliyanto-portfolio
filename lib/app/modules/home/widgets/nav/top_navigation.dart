import 'package:flutter/material.dart';
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

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 36,
        24,
        isMobile ? 20 : 36,
        8,
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              'FA',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const Spacer(),
          if (!isMobile) ...[
            _NavButton(
              key: const ValueKey('nav_home'),
              label: 'Home',
              onTap: widget.onTapHero,
            ),
            _NavButton(
              key: const ValueKey('nav_experience'),
              label: 'Experience',
              onTap: widget.onTapProjects,
            ),
            _NavButton(
              key: const ValueKey('nav_contact'),
              label: 'Contact',
              onTap: widget.onTapContact,
            ),
            const SizedBox(width: 16),
          ],
          if (!isMobile)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFFEAE7E1)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Text(
                'Jakarta, Indonesia',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5D5C57),
                ),
              ),
            )
          else
            Obx(() {
              final isOpen = Get.find<HomeController>().isMenuOpen.value;
              return GestureDetector(
                onTap: Get.find<HomeController>().toggleMenu,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isOpen
                        ? const Color(0xFF161616)
                        : const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEAE7E1)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isOpen
                        ? const Icon(
                            Icons.close_rounded,
                            key: ValueKey('close'),
                            size: 20,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.menu_rounded,
                            key: ValueKey('menu'),
                            size: 20,
                            color: Color(0xFF353535),
                          ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  const _NavButton({required this.label, required this.onTap, super.key});

  final String label;
  final VoidCallback onTap;

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
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: _hovering
                  ? const Color(0xFFAAAAAA)
                  : const Color(0xFF353535),
              fontWeight: FontWeight.w600,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
