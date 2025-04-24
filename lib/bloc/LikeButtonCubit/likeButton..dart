import 'package:bloc/bloc.dart';

class LikeButtonCubit extends Cubit<bool> {

  LikeButtonCubit() : super(false);
  void toggleLike() => emit(!state);
}