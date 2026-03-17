import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:personal_portfolio/app/modules/home/controllers/home_controller.dart';

class FooterSection extends StatelessWidget {
  FooterSection({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Wrap(
            children: [
              _buildIcon(
                FontAwesomeIcons.github,
                'https://github.com/FerdyApriliyanto',
              ),
              _buildIcon(
                FontAwesomeIcons.linkedin,
                'https://www.linkedin.com/in/ferdy-apriliyanto-8a29a9191/',
              ),
              _buildIcon(
                FontAwesomeIcons.instagram,
                'https://www.instagram.com/ferdyapriliyanto/',
              ),
              _buildIcon(
                FontAwesomeIcons.envelope,
                'mailto:ferdya7414@gmail.com',
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            '© 2026 Ferdy Apriliyanto. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(FaIconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => controller.openUrl(url),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: FaIcon(icon, size: 18, color: Colors.black87),
        ),
      ),
    );
  }
}
