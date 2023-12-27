import 'package:daily_quote/quote/model.dart';
import 'package:daily_quote/quote/repository.dart';
import 'package:flutter/material.dart';

class QuoteViewModel with ChangeNotifier {
  final QuoteRepository _quoteRepository = QuoteRepository();
  Quote _quote = QuoteRepository().getRandomQuote();

  void changeQuote() {
    _quote = _quoteRepository.getRandomQuote();
    notifyListeners();
  }

  Quote get quote => _quote;
}
