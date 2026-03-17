import 'package:url_launcher/url_launcher.dart';

class UrlService {
  static Future<void> open(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
