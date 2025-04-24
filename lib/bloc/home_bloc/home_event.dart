part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class HomeVideoLoadEvent extends HomeEvent {}

class HomeVideoLoadSucess extends HomeEvent {}

class HomeVideoLoadError extends HomeEvent {}

class HomeVideoLikeEvent extends HomeEvent{
  final int index;
  HomeVideoLikeEvent({required this.index});
}