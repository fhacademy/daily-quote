import 'package:daily_quote/constants.dart';
import 'package:daily_quote/quote/viewmodel.dart';
import 'package:daily_quote/screens/favorites.dart';
import 'package:daily_quote/screens/parts/add_quote_form.dart';
import 'package:daily_quote/screens/parts/quote_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<QuoteViewModel>();
    ThemeData theme = Theme.of(context);
    final quoteAuthor = viewModel.quote.author;
    final quoteText = viewModel.quote.text;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: MainAppBar(height: 150, quoteAuthor: quoteAuthor),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: (40.0),
                    backgroundImage: AssetImage(ImagesPath.profile),
                  ),
                  Text(
                    'Bard',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'barda@google.com',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(Intl.message('Profile Settings')),
              trailing: const Icon(Icons.settings),
            ),
            ListTile(
              title: Text(Intl.message("Quit")),
              trailing: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QuoteDisplay(quoteText: quoteText),
                    Text(
                      Intl.message(DateFormat(
                              'EE, dd MMMM yyyy', Intl.getCurrentLocale())
                          .format(DateTime.now())),
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.yellow),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            tooltip: Intl.message('Add a new quote'),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: const EdgeInsets.all(20.0),
                                      child: const AddQuoteForm(),
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.post_add,
                              color: theme.colorScheme.onPrimary,
                            )),
                        IconButton(
                          padding: EdgeInsets.zero,
                          tooltip: Intl.message('Add to favorites'),
                          onPressed: () {
                            viewModel.favorite();
                          },
                          isSelected: viewModel.isFavorite,
                          icon: Icon(
                            Icons.favorite_outline,
                            color: theme.colorScheme.onPrimary,
                          ),
                          selectedIcon: Icon(
                            Icons.favorite,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          tooltip: Intl.message('View favorites'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const FavoritesScreen(),
                            ));
                          },
                          icon: Icon(
                            Icons.read_more,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

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
                Provider.of<QuoteViewModel>(context, listen: false)
                    .changeQuote();
              },
              icon: Icon(
                Icons.space_dashboard,
                color: theme.colorScheme.onPrimary,
              )),
          Text(
            quoteAuthor,
            style: theme.textTheme.titleLarge!
                .copyWith(color: theme.colorScheme.onPrimary),
          ),
          GestureDetector(
            onTap: () => scaffoldState!.openEndDrawer(),
            child: const CircleAvatar(
              backgroundImage: AssetImage(ImagesPath.profile),
            ),
          ),
        ],
      ),
    );
  }
}
