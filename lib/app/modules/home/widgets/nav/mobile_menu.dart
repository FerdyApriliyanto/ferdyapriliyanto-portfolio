import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';
import 'package:personal_portfolio/app/theme/app_gradients.dart';

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
    final width = MediaQuery.sizeOf(context).width;
    final useGlass = width >= 760;

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
                color: AppColors.overlayBackdrop,
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: SafeArea(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 84, 16, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: useGlass ? 18 : 0,
                            sigmaY: useGlass ? 18 : 0,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: useGlass
                                  ? AppGradients.mobileMenuSurface
                                  : null,
                              color: useGlass
                                  ? null
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: AppColors.borderMuted),
                              boxShadow: useGlass
                                  ? const [
                                      BoxShadow(
                                        color: AppColors.shadowMuted,
                                        blurRadius: 32,
                                        offset: Offset(0, 12),
                                      ),
                                    ]
                                  : null,
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
                                    onPressed: () => controller.openUrl(
                                      HomeController.whatsappUrl,
                                    ),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.brandDark,
                                      foregroundColor: AppColors.onDark,
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
                  ? Border.all(color: AppColors.borderAccent)
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 20,
                  color: widget.active
                      ? AppColors.textStrong
                      : AppColors.textTertiary,
                ),
                const SizedBox(width: 14),
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: widget.active
                        ? AppColors.textStrong
                        : AppColors.textTertiary,
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
                    color: AppColors.textStrong,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
