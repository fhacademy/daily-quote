import 'package:daily_quote/quote/viewmodel.dart';
import 'package:daily_quote/screens/parts/list_quote_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message("Quotes")),
      ),
      body: Consumer<QuoteViewModel>(
          builder: (BuildContext context, model, child) {
        List quotes = model.quotes;
        return ListView.separated(
          itemBuilder: (BuildContext context, index) {
            if (index == quotes.length) {
              return const SizedBox(
                height: 40.0,
              );
            }
            return ListQuoteDisplay(
              quotes: quotes,
              index: index,
              onFavoritePressed: () {
                model.updateFavoriteFrom(quote: quotes[index]);
              },
              isFavorite: model.checkFavoriteFor(quote: quotes[index]),
            );
          },
          separatorBuilder: (BuildContext context, index) => const Divider(),
          itemCount: quotes.length + 1,
        );
      }),
    );
  }
}
