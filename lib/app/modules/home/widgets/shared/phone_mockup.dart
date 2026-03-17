import 'package:flutter/material.dart';

class PhoneMockup extends StatelessWidget {
  const PhoneMockup({
    required this.assetPath,
    required this.width,
    required this.height,
    this.lightBackground = false,
    super.key,
  });

  final String assetPath;
  final double width;
  final double height;
  final bool lightBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.12),
        border: lightBackground
            ? null
            : Border.all(color: const Color(0xFFDDD9D3), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
