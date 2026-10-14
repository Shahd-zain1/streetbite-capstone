import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.photoBase64,
  });

  final String uid;
  final String name;
  final String email;
  final String? photoBase64;

  String get firstName {
    final trimmed = name.trim();
    return trimmed.isEmpty ? email : trimmed.split(' ').first;
  }

  @override
  List<Object?> get props => [uid, name, email, photoBase64];
}
