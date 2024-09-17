import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(BuildContext context, String url) async {
  // Abrir el sitio web
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}

List<Map<String, String>> getCategories() {
  List<Map<String, String>> categories = [
    {"Fiction": "assets/fiction.png"},
    {"Classic": "assets/classic.png"},
    {"Romance": "assets/romance.png"},
    {"Mystery": "assets/mystery.png"},
    {"Fantasy": "assets/fantasy.png"},
    {"History": "assets/history.png"},
    {"Comic": "assets/comic.png"},
    {"Crime": "assets/crime.png"}
  ];
  return categories;
}