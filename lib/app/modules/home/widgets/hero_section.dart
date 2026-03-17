import 'package:flutter/material.dart';

import 'portfolio_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    required this.name,
    required this.role,
    required this.headline,
    required this.summary,
    required this.onViewWork,
    required this.onContact,
    super.key,
  });

  final String name;
  final String role;
  final String headline;
  final String summary;
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 860;

    return FadeTransition(
      opacity: _fade,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 24, end: 0),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        builder: (context, offset, child) {
          return Transform.translate(offset: Offset(0, offset), child: child);
        },
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: EdgeInsets.all(isMobile ? 24 : 36),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: const Color(0xFFEEEAE3)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 40,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: isMobile
              ? _HeroMobile(
                  name: widget.name,
                  role: widget.role,
                  headline: widget.headline,
                  summary: widget.summary,
                  onViewWork: widget.onViewWork,
                  onContact: widget.onContact,
                )
              : _HeroDesktop(
                  name: widget.name,
                  role: widget.role,
                  headline: widget.headline,
                  summary: widget.summary,
                  onViewWork: widget.onViewWork,
                  onContact: widget.onContact,
                ),
        ),
      ),
    );
  }
}

class _HeroDesktop extends StatelessWidget {
  const _HeroDesktop({
    required this.name,
    required this.role,
    required this.headline,
    required this.summary,
    required this.onViewWork,
    required this.onContact,
  });

  final String name;
  final String role;
  final String headline;
  final String summary;
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 14,
                runSpacing: 14,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  _AvatarBadge(),
                  _InfoPill(
                    label: 'Jakarta, Indonesia',
                    icon: Icons.place_outlined,
                  ),
                  _AvailabilityPill(),
                ],
              ),
              const SizedBox(height: 34),
              Text(
                name,
                style: textTheme.displayLarge?.copyWith(
                  fontSize: 74,
                  height: 0.96,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF121212),
                  letterSpacing: -2.6,
                ),
              ),
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Flutter-focused '),
                    TextSpan(
                      text: role,
                      style: const TextStyle(color: Color(0xFFFC6B10)),
                    ),
                    const TextSpan(text: ' crafting reliable mobile apps.'),
                  ],
                ),
                style: textTheme.headlineMedium?.copyWith(
                  fontSize: 40,
                  height: 1.12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFB8B1AB),
                  letterSpacing: -1.2,
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  headline,
                  style: textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF716B65),
                    height: 1.8,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  PortfolioButton(
                    label: 'View experience',
                    primary: true,
                    onTap: onViewWork,
                  ),
                  PortfolioButton(label: 'Contact', onTap: onContact),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 28),
        Expanded(flex: 4, child: _ProfilePanel(summary: summary)),
      ],
    );
  }
}

class _HeroMobile extends StatelessWidget {
  const _HeroMobile({
    required this.name,
    required this.role,
    required this.headline,
    required this.summary,
    required this.onViewWork,
    required this.onContact,
  });

  final String name;
  final String role;
  final String headline;
  final String summary;
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 14,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            _AvatarBadge(),
            _InfoPill(label: 'Jakarta, Indonesia', icon: Icons.place_outlined),
            _AvailabilityPill(),
          ],
        ),
        const SizedBox(height: 26),
        Text(
          name,
          style: textTheme.displayLarge?.copyWith(
            fontSize: 46,
            height: 0.96,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF121212),
            letterSpacing: -1.8,
          ),
        ),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Flutter-focused '),
              TextSpan(
                text: role,
                style: const TextStyle(color: Color(0xFFFC6B10)),
              ),
              const TextSpan(text: ' crafting reliable mobile apps.'),
            ],
          ),
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 28,
            height: 1.12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFB8B1AB),
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          headline,
          style: textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF716B65),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            PortfolioButton(
              label: 'View experience',
              primary: true,
              onTap: onViewWork,
            ),
            PortfolioButton(label: 'Contact', onTap: onContact),
          ],
        ),
        const SizedBox(height: 24),
        _ProfilePanel(summary: summary),
      ],
    );
  }
}

class _ProfilePanel extends StatelessWidget {
  const _ProfilePanel({required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F8F5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFECE7DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: textTheme.labelLarge?.copyWith(
              color: const Color(0xFF7A746F),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            summary,
            style: textTheme.titleLarge?.copyWith(
              fontSize: 24,
              height: 1.38,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1D1D1D),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 22),
          const _MetricRow(label: 'Experience', value: '3+ years'),
          const SizedBox(height: 14),
          const _MetricRow(label: 'Core stack', value: 'Flutter, GetX, Bloc'),
          const SizedBox(height: 14),
          const _MetricRow(label: 'Focus', value: 'Production mobile apps'),
        ],
      ),
    );
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFBF8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE7E1D9), width: 1.6),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 22,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Transform.scale(
                scale: 1.28,
                alignment: const Alignment(0, -0.08),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.matrix([
                    0.55,
                    0.55,
                    0.55,
                    0,
                    -18,
                    0.55,
                    0.55,
                    0.55,
                    0,
                    -18,
                    0.55,
                    0.55,
                    0.55,
                    0,
                    -18,
                    0,
                    0,
                    0,
                    0.98,
                    0,
                  ]),
                  child: Image.asset(
                    'assets/profile/profile.jpeg',
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -0.05),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0x04FFFFFF), const Color(0x34000000)],
                  ),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(color: Color(0x22000000)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F8F5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE8E3DB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF6C6661)),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF3A3734),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE8E3DB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFF33E27A),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x5533E27A),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Open to work',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF2C2A27),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF7A746F),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF1C1C1C),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
