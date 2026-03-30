import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:personal_portfolio/app/models/contact_link.dart';
import 'package:personal_portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:personal_portfolio/app/theme/app_colors.dart';
import 'package:personal_portfolio/app/theme/app_radius.dart';
import 'package:personal_portfolio/app/theme/app_spacing.dart';

import '../../widgets/shared/portfolio_button.dart';
import '../../widgets/shared/section_title.dart';

class ContactSection extends StatelessWidget {
  final controller = Get.find<HomeController>();

  ContactSection({required this.contacts, super.key});

  final List<ContactLink> contacts;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(isMobile ? AppSpacing.xl : 32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 32,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            eyebrow: 'Contact',
            title: 'Available for Flutter and mobile product opportunities.',
            description:
                'Reach out for mobile development roles, freelance collaboration, or product teams needing Flutter implementation support.',
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.lg,
            children: contacts
                .map(
                  (contact) =>
                      _ContactCard(contact: contact, isMobile: isMobile),
                )
                .toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          PortfolioButton(
            label: 'Start a Conversation',
            primary: true,
            onTap: () => controller.openUrl(
              'mailto:ferdya7414@gmail.com?subject=Project%20Inquiry&body=Hi%20Ferdy%2C%20I%20would%20like%20to%20discuss%20a%20project%20opportunity.',
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.contact, required this.isMobile});

  final ContactLink contact;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: isMobile ? double.infinity : 340,
      padding: const EdgeInsets.all(AppSpacing.pageMobile),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.borderPanel),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contact.label,
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          SelectableText(
            contact.value,
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
