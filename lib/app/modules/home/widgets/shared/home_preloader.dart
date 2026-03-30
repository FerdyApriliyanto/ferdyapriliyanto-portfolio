import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';
import 'package:personal_portfolio/app/theme/app_gradients.dart';
import 'package:personal_portfolio/app/theme/app_shadows.dart';

class HomePreloader extends StatefulWidget {
  const HomePreloader({required this.child, super.key});

  final Widget child;

  @override
  State<HomePreloader> createState() => _HomePreloaderState();
}

class _HomePreloaderState extends State<HomePreloader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  bool _visible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 1450));
      if (!mounted) return;
      setState(() => _visible = false);
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;

    return Stack(
      children: [
        widget.child,
        IgnorePointer(
          ignoring: !_visible,
          child: AnimatedOpacity(
            opacity: _visible ? 1 : 0,
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeOutCubic,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: AppGradients.pageBackground,
              ),
              child: Center(
                child: Container(
                  width: isMobile ? 220 : 280,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 28,
                    vertical: isMobile ? 24 : 28,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.heroSurface,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.borderMuted),
                    boxShadow: AppShadows.softPanel,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          final scale = 0.96 + (_pulseController.value * 0.08);
                          return Transform.scale(scale: scale, child: child);
                        },
                        child: Container(
                          width: isMobile ? 66 : 72,
                          height: isMobile ? 66 : 72,
                          decoration: const BoxDecoration(
                            gradient: AppGradients.brandDark,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'FA',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              color: AppColors.onDark,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Preparing portfolio',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.textStrong,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Loading selected work and polished mobile details.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 18),
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              final delay = index * 0.18;
                              final phase =
                                  ((_pulseController.value - delay) % 1.0)
                                      .clamp(0.0, 1.0);
                              final active = phase < 0.5;

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: active ? 18 : 8,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: active
                                      ? AppColors.textPrimary
                                      : AppColors.borderAccent,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
