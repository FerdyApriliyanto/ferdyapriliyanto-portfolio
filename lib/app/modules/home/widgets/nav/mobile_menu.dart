import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class MobileMenuOverlay extends StatelessWidget {
  const MobileMenuOverlay({
    required this.isOpen,
    required this.onClose,
    required this.onTapHome,
    required this.onTapExperience,
    required this.onTapContact,
    super.key,
  });

  final bool isOpen;
  final VoidCallback onClose;
  final VoidCallback onTapHome;
  final VoidCallback onTapExperience;
  final VoidCallback onTapContact;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.04),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: isOpen
          ? GestureDetector(
              key: const ValueKey('open'),
              onTap: onClose,
              child: Container(
                color: const Color(0x66000000),
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: SafeArea(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 84, 16, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xEFFFFFFF), Color(0xE8FFFCF7)],
                              ),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: const Color(0xFFEAE7E1)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1A000000),
                                  blurRadius: 32,
                                  offset: Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MobileMenuItem(
                                  label: 'Home',
                                  icon: Icons.home_outlined,
                                  active: controller.activeSection.value == 'home',
                                  onTap: onTapHome,
                                ),
                                MobileMenuItem(
                                  label: 'Experience',
                                  icon: Icons.work_outline,
                                  active:
                                      controller.activeSection.value ==
                                      'experience',
                                  onTap: onTapExperience,
                                ),
                                MobileMenuItem(
                                  label: 'Contact',
                                  icon: Icons.mail_outline,
                                  active:
                                      controller.activeSection.value == 'contact',
                                  onTap: onTapContact,
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton(
                                    onPressed: onTapContact,
                                    style: FilledButton.styleFrom(
                                      backgroundColor: const Color(0xFF1A1A1A),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text('Let\'s talk'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(key: ValueKey('closed')),
    );
  }
}

class MobileMenuItem extends StatefulWidget {
  const MobileMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.active,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool active;

  @override
  State<MobileMenuItem> createState() => _MobileMenuItemState();
}

class _MobileMenuItemState extends State<MobileMenuItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          width: double.infinity,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: widget.active
                  ? const Color(0xFFF6EFE5)
                  : _hovering
                  ? const Color(0xFFF7F5F2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: widget.active
                  ? Border.all(color: const Color(0xFFE6DBCD))
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 20,
                  color: widget.active
                      ? const Color(0xFF1F1D1A)
                      : const Color(0xFF353535),
                ),
                const SizedBox(width: 14),
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: widget.active
                        ? const Color(0xFF1F1D1A)
                        : const Color(0xFF353535),
                    fontWeight: widget.active
                        ? FontWeight.w700
                        : FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (widget.active)
                  const Icon(
                    Icons.arrow_outward_rounded,
                    size: 18,
                    color: Color(0xFF1F1D1A),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
