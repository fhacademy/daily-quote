import 'package:daily_quote/quote/view_model.dart';
import 'package:daily_quote/screens/parts/list_quote_display.dart';
import 'package:daily_quote/screens/quotes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message("Favorites")),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const QuotesScreen(),
              ));
            },
            child: Text(Intl.message("Quotes")),
          ),
        ],
      ),
      body: Consumer<QuoteViewModel>(
          builder: (BuildContext context, model, child) {
        List favorites = model.favorites;
        return ListView.separated(
          itemBuilder: (BuildContext context, index) {
            if (index == favorites.length) {
              return const SizedBox(
                height: 40.0,
              );
            }
            return ListQuoteDisplay(
              quotes: favorites,
              index: index,
              onFavoritePressed: () {
                model.updateFavoriteFrom(quote: favorites[index]);
              },
            );
          },
          separatorBuilder: (BuildContext context, index) => const Divider(),
          itemCount: favorites.length + 1,
        );
      }),
    );
  }
}
