import 'package:logintestapp/domain/model/token.dart';

class TokenDto {
  TokenDto({
    required this.jwt,
    required this.refreshTkn,
  });
  final String jwt;
  final String refreshTkn;

  Token toDomain() => Token(
    jwt: jwt,
    refreshTkn: refreshTkn,
  );

  static TokenDto fromDomain(Token e) => TokenDto(
    jwt: e.jwt,
    refreshTkn: e.refreshTkn,
  );

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'refresh_token': refreshTkn,
  };

  static TokenDto fromJson(Map<String, dynamic> json) {
    return TokenDto(
      jwt: json['jwt'],
      refreshTkn: json['refresh_token'],
    );
  }
}
