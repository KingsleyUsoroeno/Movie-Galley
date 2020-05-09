import 'package:flutter/material.dart';
import 'package:movies/screens/home_screen.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Gallery',
      theme: ThemeData(
          primaryColor: Color(0xFF0A0A0A)
      ),
      home: HomeScreen(),
    );
  }
}