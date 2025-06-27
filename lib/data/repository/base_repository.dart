import 'package:logintestapp/data/source/local_source.dart';
import 'package:logintestapp/data/source/rest_source.dart';

abstract class BaseRepository {
  final RestSource _restSource;
  final LocalSource _localSource;

  BaseRepository({
    required RestSource restSource,
    required LocalSource localSource,
  }) : _restSource = restSource,
       _localSource = localSource;

  Future<T> makeRequest<T>(
    Future<T> Function(String token) request,
  ) async {
    final token = await _localSource.getToken();
    try {
      return await request(token!.jwt);
    } on UnauthorizedException {
      final newToken = await _restSource.refreshToken(token!.refreshTkn);
      await _localSource.saveToken(newToken);
      return request(newToken.jwt);
    }
  }
}
