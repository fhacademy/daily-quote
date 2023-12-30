import 'dart:collection';
import 'package:daily_quote/quote/model.dart';
import 'package:daily_quote/quote/repository.dart';
import 'package:daily_quote/store/quote_data.dart';
import 'package:flutter/material.dart';

class QuoteViewModel with ChangeNotifier {
  final QuoteRepository _quoteRepository = QuoteRepository();
  final _quoteStorage = QuoteStore();
  final _favoriteQuoteStorage = FavoriteQuoteStore();
  Quote _quote = QuoteRepository().getRandomQuote();

  QuoteViewModel() {
    _load();
  }

  void _load() {
    _quoteStorage.read().then((value) {
      if (value != null) _quoteRepository.quotes = value;
    });
    _favoriteQuoteStorage.read().then((value) {
      if (value != null) {
        _quoteRepository.favorites = value;
        notifyListeners();
      }
    });
  }

  void changeQuote() {
    _quote = _quoteRepository.getRandomQuote();
    notifyListeners();
  }

  void add(String text, {String author = "Anonyma"}) {
    _quoteRepository.add(text: text, author: author);
    notifyListeners();
    _quoteStorage.write(quotes);
  }

  void favorite() {
    _quoteRepository.updateFavorites(favorite: _quote);
    notifyListeners();
  }

  void updateFavoriteFrom({required Quote quote}) {
    _quoteRepository.updateFavorites(favorite: quote);
    notifyListeners();
    _favoriteQuoteStorage.write(favorites);
  }

  bool checkFavoriteFor({required Quote quote}) {
    return favorites.contains(quote);
  }

  Quote get quote => _quote;
  bool get isFavorite => favorites.contains(quote);
  UnmodifiableListView<Quote> get favorites =>
      UnmodifiableListView<Quote>(_quoteRepository.getFavorites());

  UnmodifiableListView<Quote> get quotes =>
      UnmodifiableListView<Quote>(_quoteRepository.getQuotes());
}
