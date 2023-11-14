import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_app/features/video/views/bloc/item/video_item_bloc.dart';
import 'package:video_player_app/features/video/views/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    context.read<VideoItemBloc>().add(LoadItems());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoItemBloc, VideoItemState>(
      listener: (context, state) {
        if (state is ItemSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<VideoItemBloc, VideoItemState>(
          builder: (context, state) {
            if (state is ItemLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading...'),
                  ],
                ),
              );
            } else if (state is ItemError) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<VideoItemBloc>().add(LoadItems());
                  },
                  child: const Text('Retry'),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
