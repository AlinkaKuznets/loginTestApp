import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintestapp/domain/repository/email_repository.dart';

class PostEmailCubit extends Cubit<PostEmailState> {
  final EmailRepository _emailRepository;

  PostEmailCubit(this._emailRepository) : super(PostEmailInitial());

  Future<void> sendCode(String email) async {
    emit(PostEmailLoading());
    try {
      await _emailRepository.postEmail(email);
      emit(PostEmailReady());
    } catch (err, st) {
      emit(PostEmailError(error: err, st: st));
    }
  }
}

sealed class PostEmailState {}

class PostEmailInitial extends PostEmailState {}

class PostEmailLoading extends PostEmailState {}

class PostEmailError extends PostEmailState {
  final Object? error;
  final StackTrace? st;

  PostEmailError({
    required this.error,
    required this.st,
  });
}

class PostEmailReady extends PostEmailState {}
