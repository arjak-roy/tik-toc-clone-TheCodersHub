import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_ui_clone/Features/reels/DataLayer/Repository/videos.dart';
import 'package:tiktok_ui_clone/Features/reels/PresentationLayer/BLoC/LikeButtonCubit/likeButton..dart';
import 'package:tiktok_ui_clone/Features/reels/PresentationLayer/BLoC/home_bloc/home_bloc.dart';
import 'package:tiktok_ui_clone/Features/reels/PresentationLayer/Pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<videosRepositoryImpl>(
      create: (context) => videosRepositoryImpl(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(context.read<videosRepositoryImpl>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TikTok Ui',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: Home(),
        ),
      ),
    );
  }
}
