import 'dart:convert';
import 'dart:io';

import 'package:daily_quote/store/data.dart';
import 'package:daily_quote/user/model.dart';

class UserStore extends Store {
  @override
  String get key => "user";

  @override
  Future<File> write(covariant User value) async {
    final String json = jsonEncode(value.toJson());
    final file = await localFile;
    return file.writeAsString(json);
  }

  @override
  Future<User?> read() async {
    try {
      final file = await localFile;
      final json = await file.readAsString();
      final map = jsonDecode(json) as Map<String, dynamic>;
      return User.fromJson(map);
    } catch (e) {
      return null;
    }
  }
}
