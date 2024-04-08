import 'package:flutter/material.dart';
import 'package:gemini_genius/pages/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'sixtyfour',
        scaffoldBackgroundColor: Colors.grey.shade600,
        primaryColor: Colors.deepPurple,
      ),
    );
  }
}
