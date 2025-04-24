import 'package:tiktok_ui_clone/Features/reels/DataLayer/Models/video_model.dart';

abstract class VideoRepository {
Future<List<VideoModel>> getVideos();
}
