import 'package:daily_quote/constants.dart';
import 'package:daily_quote/quote/view_model.dart';
import 'package:daily_quote/screens/favorites.dart';
import 'package:daily_quote/screens/parts/add_quote_form.dart';
import 'package:daily_quote/screens/parts/quote_display.dart';
import 'package:daily_quote/screens/quotes.dart';
import 'package:daily_quote/user/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name = "";
  String? _email;

  @override
  Widget build(BuildContext context) {
    var quoteModel = context.watch<QuoteViewModel>();
    var userModel = context.watch<UserViewModel>();
    ThemeData theme = Theme.of(context);
    final quoteAuthor = quoteModel.quote.author;
    final quoteText = quoteModel.quote.text;

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
                    (userModel.user != null) ? userModel.user!.name : "Quote",
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (userModel.user != null &&
                            userModel.user!.email.toString().isNotEmpty)
                        ? userModel.user!.email.toString()
                        : "@Quote",
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(Intl.message('Profile Settings')),
              trailing: const Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(Intl.message("Update your profile")),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text(Intl.message("Name")),
                          ),
                          keyboardType: TextInputType.name,
                          onChanged: (value) => setState(() {
                            _name = value;
                          }),
                          initialValue: (userModel.user != null)
                              ? userModel.user!.name
                              : "",
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text(Intl.message("Email")),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => setState(() {
                            _email = value;
                          }),
                          initialValue: (userModel.user != null)
                              ? userModel.user!.email
                              : "",
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Provider.of<UserViewModel>(
                            context,
                            listen: false,
                          ).update(name: _name, email: _email);
                          Navigator.of(context).pop();
                        },
                        child: Text(Intl.message("Ok")),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: Text(Intl.message("Quit")),
              trailing: const Icon(Icons.logout),
              onTap: () {
                //quit app
              },
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
                            quoteModel.favorite();
                          },
                          isSelected: quoteModel.isFavorite,
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
                        IconButton(
                          padding: EdgeInsets.zero,
                          tooltip: Intl.message('View quotes'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const QuotesScreen(),
                            ));
                          },
                          icon: Icon(
                            Icons.view_stream,
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
