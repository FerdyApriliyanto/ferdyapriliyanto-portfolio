import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      title: 'Ferdy Apriliyanto | Personal Portfolio',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFCFCFA),
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9BAA9D),
          brightness: Brightness.light,
          primary: const Color(0xFF1E1E1E),
          secondary: const Color(0xFFDCE6DF),
          surface: const Color(0xFFFFFFFF),
        ),
      ),
    ),
  );
}
