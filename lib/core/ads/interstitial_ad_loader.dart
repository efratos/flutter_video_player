import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

class InterstitialAdLoader {
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;

  Future<void> loadInterstitialAd() async {
    final adRequest = AdRequest();
    await InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910',
      request: adRequest,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (error) {
          _isInterstitialAdReady = false;
          print('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  InterstitialAd get interstitialAd => _interstitialAd;

  bool get isInterstitialAdReady => _isInterstitialAdReady;
}
