import 'package:flutter/material.dart';
import 'package:video_player_app/features/video/domain/entities/video_entity.dart';
import 'package:video_player_app/features/video/views/bloc/item/video_item_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_app/features/video/views/cubit/cubit/display_list_mode_cubit.dart';
import 'package:video_player_app/features/video/views/pages/video_player_screen.dart';
import 'package:video_player_app/features/video/views/widgets/grid_view_widget.dart';
import 'package:video_player_app/features/video/views/widgets/list_view_widget.dart';
import '../../../../core/ads/interstitial_ad_loader.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final InterstitialAdLoader _interstitialAdLoader = InterstitialAdLoader();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    initializeAds();
  }

  Future<void> initializeAds() async {
    await _interstitialAdLoader.loadInterstitialAd();
  }

  void _launchAppStore() async {
    var url = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.blackdevo.wulo&pcampaignid=web_share');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareApp() {
    Share.share(
        'Check out this awesome app: https://play.google.com/store/apps/details?id=com.blackdevo.wulo&pcampaignid=web_share');
  }

  void navigateToVideoPlayer(VideoEntity video) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VideoPLayerScreen(
                video: video,
                interstitialAdLoader: _interstitialAdLoader,
                refreshAds: () {
                  _interstitialAdLoader.loadInterstitialAd();
                },
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayListModeCubit, bool>(
      builder: (context, liststate) {
        return BlocBuilder<VideoItemBloc, VideoItemState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: state is ItemSuccess
                  ? Color(int.parse(
                      state.items.appBackgroundHexColor.replaceAll('#', ''),
                      radix: 16))
                  : Colors.white,
              appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: const Text("Video Player"),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.star),
                      onPressed: _launchAppStore,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: _shareApp,
                    ),
                    IconButton(
                      icon: Icon(liststate ? Icons.grid_on : Icons.list),
                      onPressed: () {
                        setState(() {
                          context
                              .read<DisplayListModeCubit>()
                              .toggleDisplayMode();
                        });
                      },
                    ),
                  ]),
              body: Builder(
                builder: (context) {
                  if (state is ItemLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ItemSuccess) {
                    return liststate
                        ? ListViewWidget(
                            videos: state.items.videos,
                            callback: (index) {
                              navigateToVideoPlayer(state.items.videos[index]);
                            },
                          )
                        : GridViewWidget(
                            videos: state.items.videos,
                            callback: (index) {
                              navigateToVideoPlayer(state.items.videos[index]);
                            },
                          );
                  } else {
                    return Text("error");
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
