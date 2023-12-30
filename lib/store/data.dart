import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class Store {
  String get key;

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$key.txt');
  }

  Future<File> write(dynamic value);

  Future<dynamic> read();
}
