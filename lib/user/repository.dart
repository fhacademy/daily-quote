import 'package:daily_quote/user/model.dart';

class UserRepository {
  List<User> get users => <User>[];
  User? user;

  void create({required String name, String? email, String? profileImagePath}) {
    user ??= User(
      email: email,
      name: name,
      profileImagePath: profileImagePath,
    );
  }

  void update({String? name, String? email, String? profileImagePath}) {
    if (user == null && name!.isNotEmpty) {
      create(name: name, email: email, profileImagePath: profileImagePath);
    } else if (user != null) {
      user!.name = name != null && name.isNotEmpty ? name : user!.name;
      user!.email = email ?? user!.email;
      user!.profileImagePath = profileImagePath ?? user!.profileImagePath;
    }
  }
}
