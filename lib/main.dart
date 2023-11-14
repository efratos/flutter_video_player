import 'package:flutter/material.dart';
import 'package:video_player_app/config/service_locator.dart';
import 'package:video_player_app/features/video/views/bloc/item/video_item_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_app/features/video/views/cubit/cubit/display_list_mode_cubit.dart';
import 'package:video_player_app/features/video/views/pages/splash_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<VideoItemBloc>(),
        ),
        BlocProvider<DisplayListModeCubit>(
          create: (context) => DisplayListModeCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Video Player',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
