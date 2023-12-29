import 'package:daily_quote/user/model.dart';

class UserRepository {
  User? _user;
  List<User> get users => <User>[];
  User? get user => _user;

  void create({required String name, String? email, String? profileImagePath}) {
    _user ??= User(
      email: email,
      name: name,
      profileImagePath: profileImagePath,
    );
  }

  void update({String? name, String? email, String? profileImagePath}) {
    if (_user == null && name != null) {
      create(name: name, email: email, profileImagePath: profileImagePath);
    } else {}
    _user!.name = name ?? _user!.name;
    _user!.email = email ?? _user!.email;
    _user!.profileImagePath = profileImagePath ?? _user!.profileImagePath;
  }
}
