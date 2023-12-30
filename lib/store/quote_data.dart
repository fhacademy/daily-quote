import 'dart:convert';
import 'dart:io';
import 'package:daily_quote/quote/model.dart';
import 'package:daily_quote/store/data.dart';

class QuoteStore extends Store {
  @override
  String get key => "quotes";

  @override
  Future<File> write(covariant List<Quote> value) async {
    final String json = jsonEncode(value);
    final file = await localFile;
    return file.writeAsString(json);
  }

  @override
  Future<List<Quote>?> read() async {
    try {
      final file = await localFile;
      final json = await file.readAsString();
      final List mapList = jsonDecode(json) as List;
      return mapList.map((quoteString) {
        return Quote.fromJson(quoteString);
      }).toList();
    } catch (e) {
      return null;
    }
  }
}

class FavoriteQuoteStore extends QuoteStore {
  @override
  String get key => "favorites";
}
