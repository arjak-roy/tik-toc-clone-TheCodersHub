part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {}

//States:
class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

//StateVideoLoadsucess
class HomeVideoLoadSucessState extends HomeState {
  //
  final List<VideoModel> videos;

  HomeVideoLoadSucessState({required this.videos});

  HomeVideoLoadSucessState copyWith({required List<VideoModel> ?videos}) => HomeVideoLoadSucessState(videos: videos??this.videos);

  @override
  List<Object?> get props => [videos];
}

class HomeVideoLoadErrorState extends HomeState {
  final String message;
  HomeVideoLoadErrorState({required this.message});
  
  @override
  List<Object?> get props => [message];
}

class HomeVideoLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}


class HomeNotlikedButton extends HomeState {
  @override
  List<Object?> get props => [];
}