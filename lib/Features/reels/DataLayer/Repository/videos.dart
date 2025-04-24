import 'package:tiktok_ui_clone/Features/reels/DataLayer/Datasources/Local_Mock/video_data.dart';
import 'package:tiktok_ui_clone/Features/reels/DataLayer/Models/video_model.dart';
import 'package:tiktok_ui_clone/Features/reels/DomainLayer/Repository/videoRepository.dart';

class videosRepositoryImpl extends VideoRepository{
  @override
  Future<List<VideoModel>> getVideos() async {
    await Future.delayed(const Duration(seconds: 1)); 
    return videoData;
  }
}