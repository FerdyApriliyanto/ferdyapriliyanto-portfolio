import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio/app/modules/home/data/home_content.dart';
import 'package:personal_portfolio/app/services/url_service.dart';

class HomeController extends GetxController {
  static const String whatsappUrl =
      'https://wa.me/6281296105392?text=Hi%20Ferdy%2C%20I%20would%20like%20to%20discuss%20a%20project%20opportunity.';

  final ScrollController scrollController = ScrollController();
  final RxBool isMenuOpen = false.obs;
  final RxBool isScrolled = false.obs;
  final RxString activeSection = 'home'.obs;

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  final GlobalKey footerKey = GlobalKey();

  final projects = HomeContent.projects;
  final skills = HomeContent.skills;
  final contacts = HomeContent.contacts;

  void toggleMenu() => isMenuOpen.value = !isMenuOpen.value;
  void closeMenu() => isMenuOpen.value = false;

  void _handleScroll() {
    isScrolled.value = scrollController.hasClients && scrollController.offset > 16;
    _updateActiveSection();
  }

  void _updateActiveSection() {
    final sections = <String, GlobalKey>{
      'home': heroKey,
      'experience': projectsKey,
      'contact': contactKey,
    };

    const activationLine = 180.0;
    String? candidate;
    double? nearestDistance;

    for (final entry in sections.entries) {
      final context = entry.value.currentContext;
      if (context == null) continue;

      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;

      final top = box.localToGlobal(Offset.zero).dy;

      if (top <= activationLine) {
        candidate = entry.key;
      } else {
        final distance = top - activationLine;
        if (candidate == null &&
            (nearestDistance == null || distance < nearestDistance)) {
          nearestDistance = distance;
          candidate = entry.key;
        }
      }
    }

    if (candidate != null && candidate != activeSection.value) {
      activeSection.value = candidate;
    }
  }

  Future<void> scrollTo(GlobalKey key) async {
    closeMenu();
    final context = key.currentContext;
    if (context == null) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !scrollController.hasClients) return;

    final width = MediaQuery.sizeOf(context).width;
    final navOffset = width < 760 ? 116.0 : 132.0;
    final extraSpacing = key == heroKey ? 12.0 : 18.0;
    final targetOffset =
        scrollController.offset +
        box.localToGlobal(Offset.zero).dy -
        navOffset -
        extraSpacing;

    await scrollController.animateTo(
      targetOffset.clamp(
        scrollController.position.minScrollExtent,
        scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 720),
      curve: Curves.easeInOutCubic,
    );

    _updateActiveSection();
  }

  Future<void> openUrl(String url) async {
    try {
      await UrlService.open(url);
    } catch (e) {
      Get.snackbar('Error', 'Failed to open link');
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());
  }
}
