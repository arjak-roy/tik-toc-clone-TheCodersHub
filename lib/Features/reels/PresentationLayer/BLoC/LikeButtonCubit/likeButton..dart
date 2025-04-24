import 'package:bloc/bloc.dart';
import 'package:tiktok_ui_clone/Features/reels/DataLayer/Repository/videos.dart';

class LikeButtonCubit extends Cubit<bool> {
  final videosRepositoryImpl repository;
  LikeButtonCubit(this.repository) : super(false);
  int toggleLike(int indx){
    repository.getVideos().then((value){
      value[indx].isLiked = !value[indx].isLiked;
      if(value[indx].isLiked == true){
        emit(true);
      }
      else{
        emit(false);
      }
    });
    return indx;
  }
}