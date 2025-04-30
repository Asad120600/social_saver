import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_saver/views/splash_screen.dart';
import 'package:social_saver/l10n/app_translations.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  String? languageCode = prefs.getString('language_code');
  String? countryCode = prefs.getString('country_code');

  Locale initialLocale = const Locale('en', 'US'); // Default
  if (languageCode != null && countryCode != null) {
    initialLocale = Locale(languageCode, countryCode);
  }

  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ["6CFC24CDE0DCE5BAC205FC372F6307E1"],
    ),
  );
  MobileAds.instance.initialize();

  try {
    await FlutterDownloader.initialize(debug: true);
  } catch (e) {
    print("FlutterDownloader Initialization Error: $e");
  }


  runApp(MyApp(initialLocale: initialLocale));}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({Key? key, required this.initialLocale}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Locale('en', 'US'), // default locale
      fallbackLocale: Locale('en', 'US'),
      title: 'QuickSaver - Video Downloader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
