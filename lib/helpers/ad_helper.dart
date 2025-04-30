// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdHelper {
//   static late BannerAd _bannerAd;
//   static bool _isBannerAdLoaded = false;
//   static InterstitialAd? _interstitialAd;

//   static BannerAd get bannerAd => _bannerAd;
//   static bool get isBannerAdLoaded => _isBannerAdLoaded;
//   static InterstitialAd? get interstitialAd => _interstitialAd;

//   static void loadBannerAd() {
//     _bannerAd = BannerAd(
//       adUnitId: 'ca-app-pub-7392042763768709/9756074664',
//       size: AdSize.banner,
//       request: AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           _isBannerAdLoaded = true;
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           ad.dispose();
//         },
//       ),
//     );
//     _bannerAd.load();
//   }

//   static void loadInterstitialAd() {
//     Future.delayed(Duration(seconds: 15), () {
//       InterstitialAd.load(
//         adUnitId: 'ca-app-pub-7392042763768709/5918097543',
//         request: AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             _interstitialAd = ad;
//             _interstitialAd!.show();
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             _interstitialAd = null;
//           },
//         ),
//       );
//     });
//   }

//   static void disposeAds() {
//     _bannerAd.dispose();
//     _interstitialAd?.dispose();
//   }
// }


import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static late BannerAd _bannerAd;
  static bool _isBannerAdLoaded = false;
  static InterstitialAd? _interstitialAd;
  static bool _isInterstitialAdLoaded = false;

  static BannerAd get bannerAd => _bannerAd;
  static bool get isBannerAdLoaded => _isBannerAdLoaded;
  static bool get isInterstitialAdLoaded => _isInterstitialAdLoaded;

  static void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-7392042763768709/9756074664',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _isBannerAdLoaded = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-7392042763768709/5918097543',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
          _isInterstitialAdLoaded = false;
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (_interstitialAd != null && _isInterstitialAdLoaded) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _isInterstitialAdLoaded = false;
    }
  }

  static void disposeAds() {
    _bannerAd.dispose();
    _interstitialAd?.dispose();
  }
}
