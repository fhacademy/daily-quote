import 'package:daily_quote/app.dart';
import 'package:daily_quote/quote/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => QuoteViewModel(),
    child: const BaseApp(),
  ));
}
