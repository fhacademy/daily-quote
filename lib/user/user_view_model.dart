import 'package:daily_quote/user/model.dart';
import 'package:daily_quote/user/repository.dart';
import 'package:flutter/material.dart';

class UserViewModel with ChangeNotifier {
  final UserRepository _repository = UserRepository();

  void create({required String name, String? email, String? profileImagePath}) {
    _repository.create(
        name: name, email: email, profileImagePath: profileImagePath);
    notifyListeners();
  }

  void update({String? name, String? email, String? profileImagePath}) {
    _repository.update(
        email: email, name: name, profileImagePath: profileImagePath);
    notifyListeners();
  }

  User? get user => _repository.user;
}
