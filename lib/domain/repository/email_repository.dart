import 'package:logintestapp/domain/model/token.dart';
import 'package:logintestapp/domain/model/user.dart';

abstract class EmailRepository {
  Future<void> postEmail(String email);

  Future<Token> postCode({
    required String email,
    required int code,
  });

  Future<User> getUser();

  Future <bool> isAuthorised();

  Future<void> logout();
}
