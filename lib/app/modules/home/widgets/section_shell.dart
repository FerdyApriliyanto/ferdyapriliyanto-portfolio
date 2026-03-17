import 'package:flutter/material.dart';

class SectionShell extends StatelessWidget {
  const SectionShell({required this.child, super.key, this.sectionKey});

  final Widget child;
  final Key? sectionKey;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width >= 1200
        ? 72.0
        : width >= 768
        ? 40.0
        : 20.0;

    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        18,
        horizontalPadding,
        18,
      ),
      child: child,
    );
  }
}
