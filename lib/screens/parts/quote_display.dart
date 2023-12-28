import 'package:flutter/material.dart';

class QuoteDisplay extends StatelessWidget {
  const QuoteDisplay({
    super.key,
    required this.quoteText,
  });

  final String quoteText;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: theme.colorScheme.onPrimary, width: 2.0)),
          color: theme.colorScheme.primary,
          elevation: 5.0,
          margin: const EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              quoteText,
              style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
            right: 50.0,
            child: Icon(
              Icons.format_quote,
              size: 50.0,
              color: theme.colorScheme.onPrimary,
            )),
      ],
    );
  }
}
