import 'package:flutter/material.dart';

class ListQuoteDisplay extends StatelessWidget {
  const ListQuoteDisplay({
    super.key,
    required this.quotes,
    required this.index,
    required this.onFavoritePressed,
    this.isFavorite = true,
  });

  final List quotes;
  final int index;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.transparent,
            elevation: 0,
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 40.0,
              top: 10.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                quotes[index].text,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 5.0,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_user,
                  size: 10.0,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  "${quotes[index].author}",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      Positioned(
        top: -5.0,
        left: 20.0,
        child: Icon(
          Icons.format_quote_outlined,
          color: theme.colorScheme.primary,
        ),
      ),
      Positioned(
        bottom: 0.0,
        right: 0.0,
        child: IconButton(
          isSelected: isFavorite,
          onPressed: onFavoritePressed,
          icon: Icon(
            Icons.favorite_outline,
            color: theme.colorScheme.primary,
          ),
          selectedIcon: Icon(
            Icons.favorite,
            color: theme.colorScheme.primary,
          ),
        ),
      )
    ]);
  }
}
