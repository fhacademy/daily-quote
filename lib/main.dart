import 'package:daily_quote/app.dart';
import 'package:daily_quote/quote/view_model.dart';
import 'package:daily_quote/user/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => QuoteViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserViewModel(),
      ),
    ],
    child: const BaseApp(),
  ));
}
