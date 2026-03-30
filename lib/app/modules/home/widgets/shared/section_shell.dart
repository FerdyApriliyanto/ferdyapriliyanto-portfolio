import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/theme/app_spacing.dart';

class SectionShell extends StatelessWidget {
  const SectionShell({required this.child, super.key, this.sectionKey});

  final Widget child;
  final Key? sectionKey;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width >= 1200
        ? AppSpacing.pageDesktop
        : width >= 768
        ? AppSpacing.pageTablet
        : AppSpacing.pageMobile;

    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        AppSpacing.sectionY,
        horizontalPadding,
        AppSpacing.sectionY,
      ),
      child: child,
    );
  }
}
