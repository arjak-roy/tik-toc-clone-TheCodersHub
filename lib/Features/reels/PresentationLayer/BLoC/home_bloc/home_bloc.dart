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
    on<HomeVideoLikeEvent>((event, Emitter<HomeState> emit) => _likeVideo(event, emit));
  }

  _likeVideo(HomeVideoLikeEvent event, Emitter<HomeState> emit) async{
    try {
        final currentState = state;
      if(currentState is HomeVideoLoadSucessState){
        //A new video list
        List<VideoModel> videos = List<VideoModel>.from(currentState.videos);
        //Specific video model ko update krke ek naya object retuern krenge copy with se
        final videoItem =  videos[event.index].copyWith(isLiked: !videos[event.index].isLiked);
        //videos list me hum update kr diye
        videos[event.index] = videoItem;
        //naya state emit kr diya
        emit(currentState.copyWith(videos: videos));
      }
    }
    catch (e) {
      emit(HomeVideoLoadErrorState(message: e.toString()));
    }
  }
  _loadVideos(HomeVideoLoadEvent event, Emitter<HomeState> emit) async{
    try {
      emit(HomeVideoLoadingState());
      final videos = await videoRepository.getVideos();
      emit(HomeVideoLoadSucessState(videos: videos));
    }
    catch (e) {
      emit(HomeVideoLoadErrorState(message: e.toString()));
    }
  }


}
