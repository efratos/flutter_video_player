import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/core/ads/interstitial_ad_loader.dart';
import 'package:video_player_app/features/video/domain/entities/video_entity.dart';

class VideoPLayerScreen extends StatefulWidget {
  final VideoEntity video;
  final InterstitialAdLoader interstitialAdLoader;
  final Function refreshAds;
  const VideoPLayerScreen({
    super.key,
    required this.video,
    required this.interstitialAdLoader,
    required this.refreshAds,
  });

  @override
  State<VideoPLayerScreen> createState() => _VideoPLayerScreenState();
}

class _VideoPLayerScreenState extends State<VideoPLayerScreen> {
  //video player
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  //ads
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;

  void fullscreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void initState() {
    super.initState();

    _interstitialAd = widget.interstitialAdLoader.interstitialAd;
    _isInterstitialAdReady = widget.interstitialAdLoader.isInterstitialAdReady;

    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        fullscreen();
        initializePlayer();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        fullscreen();
        initializePlayer();
      },
    );

    _showInterstitialAd();
  }

  Future<void> _showInterstitialAd() async {
    if (_isInterstitialAdReady) {
      await _interstitialAd.show();
    } else {
      print('Interstitial ad is not ready yet.');
    }
  }

  Future<void> initializePlayer() async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl!));

    await videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    widget.refreshAds();
    super.dispose();
  }

  @override
  void deactivate() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: chewieController != null &&
                    chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(
                    controller: chewieController!,
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Loading'),
                    ],
                  ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
