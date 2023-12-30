import 'dart:math';

import 'package:daily_quote/quote/model.dart';

class QuoteRepository {
  List<Quote> _quotes = [
    Quote(
        text:
            'The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.',
        author: 'Helen Keller'),
    Quote(
        text:
            'The future belongs to those who believe in the beauty of their dreams.',
        author: 'Eleanor Roosevelt'),
    Quote(
        text:
            'The only person you are destined to become is the person you decide to be.',
        author: 'Ralph Waldo Emerson'),
    Quote(
        text: 'The only way to do great work is to love what you do.',
        author: 'Steve Jobs'),
    Quote(text: 'If you can dream it, you can do it.', author: 'Walt Disney'),
    Quote(
        text:
            'The only limit to our realization of tomorrow will be our doubts of today.',
        author: 'Franklin D. Roosevelt'),
    Quote(
        text:
            'The greatest thing in the world is to know that we are loved by someone.',
        author: 'Victor Hugo'),
    Quote(
        text:
            'The only thing that stands between you and your dream is the will to try.',
        author: 'Jim Rohn'),
    Quote(
        text:
            'If you are always trying to be normal, you will never know how amazing you can be.',
        author: 'Maya Angelou'),
    Quote(
        text:
            'The only way to do great work is to love what you do. If you haven\'t found it yet, keep looking. Don\'t settle.',
        author: 'Steve Jobs'),
    Quote(
        text:
            'The only person you are destined to become is the person you decide to be.',
        author: 'Ralph Waldo Emerson'),
    Quote(
        text:
            'The only way to do great work is to love what you do. If you haven’t found it yet, keep looking. Don’t settle.',
        author: 'Steve Jobs'),
    Quote(
        text:
            'The only person you are destined to become is the person you decide to be.',
        author: 'Ralph Waldo Emerson'),
    Quote(
        text:
            'The only way to do great work is to love what you do. If you haven’t found it yet, keep looking. Don’t settle.',
        author: 'Steve Jobs'),
  ];
  List<Quote> _favorites = [];

  set quotes(List<Quote> quotes) {
    _quotes = quotes;
  }

  set favorites(List<Quote> quotes) {
    _favorites = quotes;
  }

  List<Quote> getQuotes() {
    return _quotes;
  }

  List<Quote> getFavorites() {
    return _favorites;
  }

  Quote getRandomQuote() {
    final randomIndex = Random().nextInt(getQuotes().length);
    return getQuotes()[randomIndex];
  }

  void add({required String text, required String author}) {
    _quotes.add(Quote(text: text, author: author));
  }

  void updateFavorites({required Quote favorite}) {
    if (_favorites.contains(favorite)) {
      _favorites.remove(favorite);
      return;
    }

    _favorites.add(favorite);
  }
}
