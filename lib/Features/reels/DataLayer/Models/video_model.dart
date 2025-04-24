
class VideoModel{

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
    required this.isLiked
  });
  //factory method to get the modal class from a json
  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        url: json['url'],
        description: json['description'],
        likes: json['likes'],
        comments: json['comments'],
        favoriteLength: json['favoriteLength'],
        shares: json['shares'], isLiked: json['isLiked'],
      );

}
