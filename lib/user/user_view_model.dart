import 'package:daily_quote/store/user_data.dart';
import 'package:daily_quote/user/model.dart';
import 'package:daily_quote/user/repository.dart';
import 'package:flutter/material.dart';

class UserViewModel with ChangeNotifier {
  final UserRepository _repository = UserRepository();
  final UserStore _storage = UserStore();

  UserViewModel() {
    _load();
  }

  void _load() {
    _storage.read().then((value) {
      if (value != null) {
        _repository.user = value;
        notifyListeners();
      }
    });
  }

  void create({required String name, String? email, String? profileImagePath}) {
    _repository.create(
        name: name, email: email, profileImagePath: profileImagePath);
    notifyListeners();
    save();
  }

  void update({String? name, String? email, String? profileImagePath}) {
    _repository.update(
        email: email, name: name, profileImagePath: profileImagePath);
    notifyListeners();
    save();
  }

  void save() {
    if (_repository.user != null) {
      _storage.write(_repository.user as User);
    }
  }

  User? get user => _repository.user;
}
