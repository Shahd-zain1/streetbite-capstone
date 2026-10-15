import 'package:streetbite/data/models/user_builder.dart';
import 'package:streetbite/domain/entities/app_user.dart';

class UserModel extends AppUser {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.photoBase64,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserBuilder()
        .uid(json['uid'] as String)
        .name(json['name'] as String? ?? '')
        .email(json['email'] as String? ?? '')
        .photoBase64(json['photoBase64'] as String?)
        .build();
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      if (photoBase64 != null) 'photoBase64': photoBase64,
    };
  }
}
