import 'package:daily_quote/quote/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddQuoteForm extends StatefulWidget {
  const AddQuoteForm({
    super.key,
  });

  @override
  State<AddQuoteForm> createState() => _AddQuoteFormState();
}

class _AddQuoteFormState extends State<AddQuoteForm> {
  final _formKey = GlobalKey<FormState>();
  String quote = "";
  String author = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
        key: _formKey,
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
              validator: (value) =>
                  value!.isEmpty ? Intl.message("Quote can't be empty") : null,
              onChanged: (value) => setState(
                () {
                  quote = value;
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Author", hintText: "Jhon Smith"),
              onChanged: (value) => setState(() {
                author = value;
              }),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2.5,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<QuoteViewModel>(context, listen: false)
                            .add(quote, author: author);
                        _formKey.currentState!.reset();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(Intl.message("New quote added !")),
                          duration: const Duration(seconds: 4),
                        ));
                      }
                    },
                    child: const Text('Add a new quote')),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook),
                  color: theme.colorScheme.primary,
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  color: theme.colorScheme.primary,
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            )
          ],
        ));
  }
}
