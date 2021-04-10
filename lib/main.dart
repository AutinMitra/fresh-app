import 'package:flutter/material.dart';
import 'package:fresh/theme/theme.dart';
import 'package:fresh/views/home.dart';
import 'package:fresh/views/link.dart';
import 'package:fresh/views/ready.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.lightMode,
      home: HomePage(),
      routes: {
        '/link': (context) => LinkPage(),
        '/ready': (context) => ReadyPage(),
      }
    );
  }
}
