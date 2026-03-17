import 'package:flutter/material.dart';

import '../../widgets/shared/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 28),
      child: const SectionTitle(
        eyebrow: 'About',
        title:
            'Mobile developer with production Flutter experience and a strong implementation focus.',
        description:
            'Experienced in building scalable Flutter applications with GetX, Bloc, and Provider, including real-time systems, REST API integration, and Firebase services. Education includes a Bachelor of Information Technology at IBI Kesatuan from 2021 to 2025, following vocational high school studies at Wikrama from 2018 to 2021.',
      ),
    );
  }
}
