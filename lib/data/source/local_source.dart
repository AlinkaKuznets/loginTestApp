import 'dart:convert';

import 'package:logintestapp/data/source/dto/token_dto.dart';
import 'package:logintestapp/domain/model/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSource {
  Token? _token;
  static const _tokenKey = 'auth_token';

  Future<void> saveToken(Token token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final dto = TokenDto.fromDomain(token);
    final jsonString = jsonEncode(dto.toJson());
    await preferences.setString(_tokenKey, jsonString);
    _token = token;
  }

  Future<Token?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final jsonString = preferences.getString(_tokenKey);
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString);
    final dto = TokenDto.fromJson(jsonMap);
    _token = dto.toDomain();
    return _token;
  }

  Future<void> removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(_tokenKey);
  }
}

