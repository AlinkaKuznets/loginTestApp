import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintestapp/domain/repository/email_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final EmailRepository _emailRepository;
  AuthCubit(this._emailRepository) : super(AuthStateLoading());

  Future<void> checkStatus() async {
    emit(AuthStateLoading());
    final status = await _emailRepository.isAuthorised();
    emit(
      AuthStateReady(isAuth: status),
    );
  }

  Future<void> logout() async {
    emit(AuthStateLoading());
    await _emailRepository.logout();
    emit(
      AuthStateReady(isAuth: false),
    );
  }
}

sealed class AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateReady extends AuthState {
  final bool isAuth;

  AuthStateReady({required this.isAuth});
}
