import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintestapp/domain/repository/email_repository.dart';

class PostCodeCubit extends Cubit<PostCodeState> {
  final EmailRepository _emailRepository;

  PostCodeCubit(this._emailRepository) : super(PostCodeInitial());

  Future<void> sendCode(String email, int code) async {
    emit(PostCodeInitial());
    try {
      await _emailRepository.postCode(email: email, code: code);
      emit(PostCodeReady());
    } catch (err, st) {
      emit(PostCodeError(error: err, st: st));
    }
  }
}

sealed class PostCodeState {}

class PostCodeInitial extends PostCodeState {}

class PostCodeLoading extends PostCodeState {}

class PostCodeError extends PostCodeState {
  final Object? error;
  final StackTrace? st;

  PostCodeError({
    required this.error,
    required this.st,
  });
}

class PostCodeReady extends PostCodeState {}
