import 'package:logintestapp/domain/model/user.dart';

class UserDto {
  UserDto({
    required this.id,
  });
  final String id;

  User toDomain() => User(id: id);

  static UserDto fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['user_id'],
    );
  }
}
