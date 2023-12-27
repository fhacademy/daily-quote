import 'package:daily_quote/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Intl.message('Flutter Demo'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
