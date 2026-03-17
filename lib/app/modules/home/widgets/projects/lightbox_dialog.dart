import 'package:flutter/material.dart';

import '../shared/carousel_controls.dart';
import '../shared/phone_mockup.dart';

class LightboxDialog extends StatefulWidget {
  const LightboxDialog({
    required this.screenshots,
    required this.initialIndex,
    super.key,
  });

  final List<String> screenshots;
  final int initialIndex;

  @override
  State<LightboxDialog> createState() => _LightboxDialogState();
}

class _LightboxDialogState extends State<LightboxDialog> {
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
                    CarouselButton(
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
                      child: PhoneMockup(
                        key: ValueKey(_current),
                        assetPath: widget.screenshots[_current],
                        width: 240,
                        height: 460,
                        lightBackground: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    CarouselButton(
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
                    (i) => DotIndicator(active: i == _current),
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
