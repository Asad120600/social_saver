import 'package:country_flags/country_flags.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_saver/l10n/app_translations.dart';

Widget buildLanguageDropdown() {
  final currentLocale = Get.locale ?? const Locale('en', 'US');

  final supportedLocales = [
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
    const Locale('ur', 'PK'),
    const Locale('ar', 'SA'),
    const Locale('fr', 'FR'),
    const Locale('de', 'DE'),
    const Locale('zh', 'CN'),
    const Locale('hi', 'IN'),
    const Locale('bn', 'BD'),
    const Locale('ru', 'RU'),
    const Locale('pt', 'PT'),
  ];

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        value: currentLocale,
        dropdownColor: Color.fromARGB(193, 59, 16, 83),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        style: const TextStyle(color: Colors.white),
        items: supportedLocales.map((locale) {
          final langMap = AppTranslations().keys[locale.toString()];
          final langName = langMap?['language_name'] ?? locale.languageCode;
          final countryCode = locale.countryCode ?? 'US';

          return DropdownMenuItem<Locale>(
            value: locale,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  CountryFlag.fromCountryCode(
                    countryCode,
                    height: 18,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      langName,
                      overflow: TextOverflow.ellipsis, // To handle overflow
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      onChanged: (Locale? locale) async {
  if (locale != null) {
    Get.updateLocale(locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    await prefs.setString('country_code', locale.countryCode ?? '');
  }
},
        selectedItemBuilder: (BuildContext context) {
          return supportedLocales.map((locale) {
            final langMap = AppTranslations().keys[locale.toString()];
            final langName =
                langMap?['language_name_english'] ?? locale.languageCode;
            final countryCode = locale.countryCode ?? 'US';

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  CountryFlag.fromCountryCode(
                    countryCode,
                    height: 16,
                    width: 22,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    langName,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis, // To handle overflow
                  ),
                ],
              ),
            );
          }).toList();
        },
      ),
    ),
  );
}
