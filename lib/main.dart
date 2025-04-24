import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_ui_clone/bloc/home_bloc/home_bloc.dart';
import 'package:tiktok_ui_clone/data/videoData/videoRepository/videoRepository.dart';
import 'package:tiktok_ui_clone/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override

  Widget build(BuildContext context) {
    return RepositoryProvider<VideoRepository>(
      create: (context) => VideoRepositoryLocal(),
      child: BlocProvider(
        create: (context) => HomeBloc(context.read<VideoRepository>()),
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
