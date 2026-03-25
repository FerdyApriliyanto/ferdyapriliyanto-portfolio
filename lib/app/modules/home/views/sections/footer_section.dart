import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:personal_portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';

class FooterSection extends StatelessWidget {
  FooterSection({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
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
            '${String.fromCharCode(169)} 2026 Ferdy Apriliyanto. All rights reserved.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: AppColors.textFooter),
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
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: AppColors.shadowSoft.withValues(alpha: 0.4),
              ),
            ],
          ),
          child: FaIcon(icon, size: 18, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
