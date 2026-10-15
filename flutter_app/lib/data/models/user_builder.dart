import 'package:streetbite/data/models/user_model.dart';

// Builder Pattern: UserModel is assembled step by step, so Firebase users and
// Firestore documents with missing fields can share one construction path.
class UserBuilder {
  String _uid = '';
  String _name = '';
  String _email = '';
  String? _photoBase64;

  UserBuilder uid(String value) {
    _uid = value;
    return this;
  }

  UserBuilder name(String value) {
    _name = value;
    return this;
  }

  UserBuilder email(String value) {
    _email = value;
    return this;
  }

  UserBuilder photoBase64(String? value) {
    _photoBase64 = value;
    return this;
  }

  UserModel build() {
    return UserModel(
      uid: _uid,
      name: _name,
      email: _email,
      photoBase64: _photoBase64,
    );
  }
}
