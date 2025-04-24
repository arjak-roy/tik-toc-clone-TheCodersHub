import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_ui_clone/Features/reels/DataLayer/Repository/videos.dart';
import 'package:tiktok_ui_clone/Features/reels/DataLayer/Models/video_model.dart';
import 'package:equatable/equatable.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final videosRepositoryImpl videoRepository;
  HomeBloc(this.videoRepository) : super(HomeInitial()) {
    on<HomeVideoLoadEvent>((event, Emitter<HomeState> emit) => _loadVideos(event, emit));
  }

  _loadVideos(HomeVideoLoadEvent event, Emitter<HomeState> emit) async{
    try {
      emit(HomeVideoLoadingState());
      final videos = await videoRepository.getVideos();
      emit(HomeVideoLoadSucessState(videos:videos));
    }
    catch (e) {
      emit(HomeVideoLoadErrorState(message: e.toString()));
    }
  }


}
