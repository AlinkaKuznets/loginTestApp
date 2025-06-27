import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintestapp/domain/repository/email_repository.dart';

class GetUserIdCubit extends Cubit<GetUserIdState> {
  final EmailRepository _emailRepository;

  GetUserIdCubit(this._emailRepository) : super(GetUserIdLoading());

  Future<void> getId() async {
    emit(GetUserIdLoading());
    try {
      final userId = await _emailRepository.getUser();
      emit(GetUserIdReady(userId: userId.id));
    } catch (err, st) {
      emit(GetUserIdError(error: err, st: st));
    }
  }
}

sealed class GetUserIdState {}

class GetUserIdLoading extends GetUserIdState {}

class GetUserIdError extends GetUserIdState {
  final Object? error;
  final StackTrace? st;

  GetUserIdError({
    required this.error,
    required this.st,
  });
}

class GetUserIdReady extends GetUserIdState {
  final String userId;
  GetUserIdReady({required this.userId});
}
