import 'package:daily_quote/constants.dart';
import 'package:daily_quote/quote/viewmodel.dart';
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
                    Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5, color: theme.colorScheme.onPrimary),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          tooltip: Intl.message('Add a new quote'),
                          iconSize: 30.0,
                          onPressed: () {
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                        child: Column(
                                      children: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: 'Quote',
                                            hintText: 'Life is good !',
                                          ),
                                          autofocus: true,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 6,
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              labelText: "Author",
                                              hintText: "Jhon Smith"),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: const Text(
                                                    'Add a new quote')),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.facebook),
                                            Icon(Icons.telegram),
                                            Icon(Icons.facebook),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 40.0,
                                        )
                                      ],
                                    )),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.post_add,
                            color: theme.colorScheme.onPrimary,
                          )),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

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
          const CircleAvatar(
            backgroundImage: AssetImage(ImagesPath.profile),
          ),
        ],
      ),
    );
  }
}
