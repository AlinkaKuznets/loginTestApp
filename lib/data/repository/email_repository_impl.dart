import 'package:logintestapp/data/repository/base_repository.dart';
import 'package:logintestapp/data/source/local_source.dart';
import 'package:logintestapp/data/source/rest_source.dart';
import 'package:logintestapp/domain/model/token.dart';
import 'package:logintestapp/domain/model/user.dart';
import 'package:logintestapp/domain/repository/email_repository.dart';

class EmailRepositoryImpl extends BaseRepository implements EmailRepository {
  final RestSource _restSource;
  final LocalSource _localSource;

  EmailRepositoryImpl({
    required super.restSource,
    required super.localSource,
  }) : _restSource = restSource,
       _localSource = localSource;

  @override
  Future<void> postEmail(String email) {
    return _restSource.postEmail(email);
  }

  @override
  Future<Token> postCode({
    required String email,
    required int code,
  }) async {
    final data = await _restSource.postCode(
      email: email,
      code: code,
    );
    _localSource.saveToken(data);
    return data;
  }

  @override
  Future<User> getUser() async {
    return makeRequest(
      (token) => _restSource.getUserId(token),
    );
  }

  @override
  Future<bool> isAuthorised() async {
    final token = await _localSource.getToken();
    return token != null;
  }

  @override
  Future<void> logout() async {
    await _localSource.removeToken();
  }
}
