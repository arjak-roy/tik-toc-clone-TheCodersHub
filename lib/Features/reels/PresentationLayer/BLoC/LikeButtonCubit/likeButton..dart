import 'package:bloc/bloc.dart';
import 'package:tiktok_ui_clone/Features/reels/DataLayer/Models/video_model.dart';
import 'package:tiktok_ui_clone/Features/reels/DataLayer/Repository/videos.dart';

class LikeButtonCubit extends Cubit<bool> {
  final videosRepositoryImpl repository;
  LikeButtonCubit(this.repository) : super(false);
   toggleLike(int indx, List<VideoModel> videos){
      // value[indx].isLiked = !value[indx].isLiked;
      if(videos[indx].isLiked){
        emit(true);
      }
      else{
        emit(false);
      }
    
  }
}