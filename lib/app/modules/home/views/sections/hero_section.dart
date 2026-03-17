import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/modules/home/widgets/hero/hero_content.dart';

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
        builder: (context, offset, child) =>
            Transform.translate(offset: Offset(0, offset), child: child),
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
              ? HeroMobile(
                  name: widget.name,
                  role: widget.role,
                  headline: widget.headline,
                  summary: widget.summary,
                  onViewWork: widget.onViewWork,
                  onContact: widget.onContact,
                )
              : HeroDesktop(
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
