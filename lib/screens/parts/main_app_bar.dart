import 'package:daily_quote/quote/view_model.dart';
import 'package:daily_quote/user/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  const MainAppBar({
    super.key,
    required this.height,
    required this.quoteAuthor,
  });

  final String quoteAuthor;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    ScaffoldState? scaffoldState =
        context.findAncestorStateOfType<ScaffoldState>();
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            iconSize: 40.0,
            onPressed: () {
              Provider.of<QuoteViewModel>(context, listen: false).changeQuote();
            },
            icon: Icon(
              Icons.space_dashboard,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          Text(
            quoteAuthor,
            style: theme.textTheme.titleLarge!
                .copyWith(color: theme.colorScheme.onPrimary),
          ),
          GestureDetector(
            onTap: () => scaffoldState!.openEndDrawer(),
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.onPrimary,
              child: Consumer<UserViewModel>(
                builder: (context, model, child) => model.user != null
                    ? Text(model.user!.name
                        .toString()
                        .substring(0, 2)
                        .toUpperCase())
                    : const Text("QT"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
