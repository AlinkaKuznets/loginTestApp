import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logintestapp/data/source/dto/token_dto.dart';
import 'package:logintestapp/data/source/dto/user_dto.dart';
import 'package:logintestapp/domain/model/token.dart';
import 'package:logintestapp/domain/model/user.dart';

class RestSource {
  static const String _baseUrl =
      'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/';

  final String _postEmailRoute = 'login';
  final String _postCodeRoute = 'confirm_code';
  final String _postRefreshRoute = 'refresh_token';
  final String _getUserIdRoute = 'auth';

  Future<void> postEmail(String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$_postEmailRoute'),
      body: jsonEncode(
        {'email': email},
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception('Failed. Try again later!');
    }
  }

  Future<Token> postCode({
    required String email,
    required int code,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$_postCodeRoute'),
      body: jsonEncode(
        {
          'email': email,
          'code': code,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception('Failed. Try again later!');
    }

    final data = jsonDecode(response.body);

    if (data == null) {
      throw Exception('JWT not found in response');
    }
    return TokenDto.fromJson(data).toDomain();
  }

  Future<User> getUserId(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl$_getUserIdRoute'),
      headers: {
        'Auth': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserDto.fromJson(data).toDomain();
    } else if (response.statusCode == 403) {
      throw UnauthorizedException();
    } else {
      throw Exception('Failed to load user ID: ${response.statusCode}');
    }
  }

  Future<Token> refreshToken(String rt) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$_postRefreshRoute'),
      body: jsonEncode(
        {
          'token': rt,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception('Failed. Try again later!');
    }

    final data = jsonDecode(response.body);

    if (data == null) {
      throw Exception('JWT not found in response');
    }
    return TokenDto.fromJson(data).toDomain();
  }
}

class UnauthorizedException {}
