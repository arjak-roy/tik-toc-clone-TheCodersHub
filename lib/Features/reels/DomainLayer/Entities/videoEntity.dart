import 'package:equatable/equatable.dart';

class Videoentity extends Equatable {
  final String? url;
  final String? description;
  final String? likes;
  final String? comments;
  final String? favoriteLength;
  final String? shares;
  final bool isLiked;

  const Videoentity({
     this.url,
     this.description,
     this.likes,
     this.comments,
     this.favoriteLength,
     this.shares,
     this.isLiked = false,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    url,
    description,
    likes,
    comments,
    favoriteLength,
    shares,
    isLiked
  ];
}