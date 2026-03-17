import 'package:flutter/material.dart';

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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
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
                      margin: const EdgeInsets.fromLTRB(16, 80, 16, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(24),
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
                            onTap: onTapHome,
                          ),
                          MobileMenuItem(
                            label: 'Experience',
                            icon: Icons.work_outline,
                            onTap: onTapExperience,
                          ),
                          MobileMenuItem(
                            label: 'Contact',
                            icon: Icons.mail_outline,
                            onTap: onTapContact,
                          ),
                        ],
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
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: _hovering ? const Color(0xFFF7F5F2) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(widget.icon, size: 20, color: const Color(0xFF353535)),
                const SizedBox(width: 14),
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF353535),
                    fontWeight: FontWeight.w600,
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
