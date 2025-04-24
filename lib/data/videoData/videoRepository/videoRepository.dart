import 'package:tiktok_ui_clone/data/videoData/video_data.dart';
import 'package:tiktok_ui_clone/models/video_model.dart';

abstract class VideoRepository {
Future<List<VideoModel>> getVideos();
}

class VideoRepositoryLocal implements VideoRepository {
  @override
  Future<List<VideoModel>> getVideos() async{
    await Future.delayed(const Duration(seconds: 1)); 
    return videoData;
  }
}
