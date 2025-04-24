class VideoModel {
  final String url;
  final String description;
  final String likes;
  final String comments;
  final String favoriteLength;
  final String shares;
  bool isLiked;

  VideoModel({
    required this.url,
    required this.description,
    required this.likes,
    required this.comments,
    required this.favoriteLength,
    required this.shares,
    this.isLiked = false,
  });

}
