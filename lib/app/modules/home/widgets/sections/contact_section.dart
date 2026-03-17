import 'package:flutter/material.dart';
import 'package:personal_portfolio/app/models/contact_link.dart';

import '../shared/portfolio_button.dart';
import '../shared/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({required this.contacts, super.key});

  final List<ContactLink> contacts;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 760;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFEEEAE3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
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
          const SizedBox(height: 24),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: contacts
                .map(
                  (contact) =>
                      _ContactCard(contact: contact, isMobile: isMobile),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          PortfolioButton(
            label: 'Start a Conversation',
            primary: true,
            onTap: () {},
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0ECE5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contact.label,
            style: textTheme.labelLarge?.copyWith(
              color: const Color(0xFF6B6762),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          SelectableText(
            contact.value,
            style: textTheme.titleMedium?.copyWith(
              color: const Color(0xFF1E1E1E),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
